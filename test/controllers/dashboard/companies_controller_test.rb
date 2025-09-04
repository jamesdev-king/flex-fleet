# frozen_string_literal: true

require "test_helper"

module Dashboard
  class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get dashboard_companies_url
    assert_response :success
  end

  test "should get new" do
    get new_dashboard_company_url
    assert_response :success
  end

  test "should create company" do
    assert_difference("Company.count") do
      post dashboard_companies_url, params: { company: { name: @company.name } }
    end

    assert_redirected_to dashboard_company_url(Company.last)
  end

  test "should show company" do
    get dashboard_company_url(@company)
    assert_response :success
  end

  test "should get edit" do
    get edit_dashboard_company_url(@company)
    assert_response :success
  end

  test "should update company" do
    patch dashboard_company_url(@company), params: { company: { name: @company.name } }
    assert_redirected_to dashboard_company_url(@company)
  end

  test "should destroy company" do
    assert_difference("Company.count", -1) do
      delete dashboard_company_url(@company)
    end

    assert_redirected_to dashboard_companies_url
  end
  end
end
