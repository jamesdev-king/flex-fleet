# frozen_string_literal: true

require "test_helper"

module Dashboard
  class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get dashboard_employees_url
    assert_response :success
  end

  test "should get new" do
    get new_dashboard_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference("Employee.count") do
      post dashboard_employees_url, params: { employee: { name: @employee.name } }
    end

    assert_redirected_to dashboard_employee_url(Employee.last)
  end

  test "should show employee" do
    get dashboard_employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_dashboard_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch dashboard_employee_url(@employee), params: { employee: { name: @employee.name } }
    assert_redirected_to dashboard_employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference("Employee.count", -1) do
      delete dashboard_employee_url(@employee)
    end

    assert_redirected_to dashboard_employees_url
  end
  end
end
