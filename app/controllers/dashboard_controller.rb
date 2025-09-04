# frozen_string_literal: true

class NavigationLink
  include ActiveModel::API

  attr_accessor :title, :controller, :url, :icon
end

class DashboardController < ApplicationController
  before_action :set_navigation
  before_action :set_company_and_organization

  def index; end

  private

  def set_company_and_organization
    Current.company ||= if session[:company_id]
                          Current.user.authenticateable.companies.find(session[:company_id])
                        else
                          Current.user.authenticateable.companies.first
                        end
    Current.organization ||= Current.company.organization
  end

  def set_navigation
    @navigation_links = [ {
      title: Company.name.pluralize,
      controller: "companies",
      url: dashboard_companies_path,
      icon: "fa-building"
    }, {
      title: Employee.name.pluralize,
      controller: "employees",
      url: dashboard_employees_path,
      icon: "fa-users"
    }, {
      title: ServiceArea.name.pluralize,
      controller: "service_areas",
      url: dashboard_service_areas_path,
      icon: "fa-earth-americas"
    } ].map { NavigationLink.new(it) }
  end
end
