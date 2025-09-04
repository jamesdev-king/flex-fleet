# frozen_string_literal: true

class SignUpsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  #  rate_limit to: 1, within: 3.minutes, only: :create, with: lambda {
  # redirect_to new_sign_up_url, alert: "Try again later."
  #  }

  def new; end

  def create
    Organization.transaction do
    @organization = Organization.create!(organization_params)
    @company = Company.new(company_params)
    @company.organization = @organization
    @company.save!

    @user = User.new(user_params)
    @user.organization = @organization
    @user.authenticateable = Employee.new
    @user.save!

    association = CompanyEmployee.new(role: CompanyEmployee.roles[:owner])
    association.employee = @user.authenticateable
    association.company = @company
    association.save!
    end

    if (user = User.authenticate_by(user_params))
      start_new_session_for user
      redirect_to after_authentication_url
    end
  end

  private

    def organization_params
      params.expect(organization: [ :name ])
    end

    def company_params
      params.expect(company: [ :name ])
    end

    def user_params
      params.expect(user: %i[email_address password password_confirmation])
    end
end
