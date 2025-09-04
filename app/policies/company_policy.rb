# frozen_string_literal: true

class CompanyPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    organization = if @record.instance_of? Symbol
                      @user.organization
                   else
                      @record.organization
                   end
    organization.grants_permission_to? %w[ owner ], @user
  end
end
