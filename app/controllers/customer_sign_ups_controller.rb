# frozen_string_literal: true

class CustomerSignUpsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  #  rate_limit to: 1, within: 3.minutes, only: :create, with: lambda {
  # redirect_to new_sign_up_url, alert: "Try again later."
  #  }
  def new; end

  def create
    @user = User.new(user_params)
    @user.organization = @company.organization
    @user.authenticateable = Customer.new(company: @company)
    @user.save!

    if (user = User.authenticate_by(user_params))
      start_new_session_for user
      redirect_to company_url(@company)
    end
  end

  private

  def user_params
    params.expect(user: %i[email_address password password_confirmation])
  end
end
