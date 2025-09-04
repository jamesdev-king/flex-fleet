# frozen_string_literal: true

class Employee < ApplicationRecord
  include Authenticateable
  include Caber::Subject
  include Caber::Object

  has_many :company_employees, dependent: :destroy, inverse_of: :employee
  has_many :companies, -> { select("companies.*, company_employees.role as role") }, through: :company_employees
  has_many :rides, inverse_of: :driver, dependent: :nullify

  accepts_nested_attributes_for :company_employees, allow_destroy: true

  def not_associated_companies
    if user.nil?
      Current.organization.companies
    else
      user.organization.companies.where.not(id: companies.pluck(:id))
    end
  end
end
