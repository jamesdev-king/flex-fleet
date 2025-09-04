# frozen_string_literal: true

require "test_helper"

class EmployeePolicyTest < ActiveSupport::TestCase
  def test_scope; end

  def test_show; end

  def test_create; end

  def test_update; end

  def test_destroy; end

  test "customer cannot create an employee" do
    user = users(:customer)
    refute_permit user, :employee, :create
  end

  test "driver cannot create an employee" do
    user = users(:driver)
    refute_permit user, :employee, :create
  end

  test "customer service cannot create an employee" do
    user = users(:service)
    refute_permit user, :employee, :create
  end

  test "admin of current company can create an employee" do
    user = users(:admin)
    Current.company = companies(:one)
    assert_permit user, :employee, :create
  end

  test "owner of current company can create an employee" do
    user = users(:owner)
    Current.company = companies(:one)
    assert_permit user, :employee, :create
  end

  test "admin of different company cannot create an employee" do
    user = users(:admin)
    Current.company = companies(:two)
    refute_permit user, :employee, :create
  end

  test "owner of different company cannot create an employee" do
    user = users(:owner)
    Current.company = companies(:two)
    refute_permit user, :employee, :create
  end
end
