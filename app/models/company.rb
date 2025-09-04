# frozen_string_literal: true

class Company < ApplicationRecord
  include Caber::Object

  belongs_to :organization
  has_many :company_employees, dependent: :destroy, inverse_of: :company
  has_many :employees, -> { select("employees.*, company_employees.role as role") }, through: :company_employees
end
