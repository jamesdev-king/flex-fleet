# frozen_string_literal: true

class EmployeePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    create?
  end

  def create?
    company = (Current.company if @record.instance_of? Symbol)

    return false if !user.employee? || company.nil?

    role = user.authenticateable.companies.where(id: company.id).first&.role
    role == CompanyEmployee.roles[:owner] || role == CompanyEmployee.roles[:admin]
  end

  def update?
    create?
  end

  def permitted_attributes
    if user.admin? || user.owner_of?(post)
      %i[title body tag_list]
    else
      [ :tag_list ]
    end
  end
end
