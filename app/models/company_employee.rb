# frozen_string_literal: true

class CompanyEmployee < ApplicationRecord
  belongs_to :company, inverse_of: :company_employees
  belongs_to :employee, inverse_of: :company_employees

  enum :role, { driver: 0, customer_support: 1, manager: 2, admin: 3, owner: 4 }
end
