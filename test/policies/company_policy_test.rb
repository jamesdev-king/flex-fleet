# frozen_string_literal: true

require "test_helper"

class CompanyPolicyTest < ActiveSupport::TestCase
  def test_scope; end

  def test_show; end

  test "user without owner permission on its organization cannot create a headless company" do
    owner = users(:owner)
    refute_permit owner, :company, :create
  end

  test "user with owner permission on its organization can create a headless company" do
    owner = users(:owner)
    owner.organization.grant_permission_to "owner", owner
    assert_permit owner, :company, :create
  end

  test "user without owner permission on its organization cannot create a company record" do
    owner = users(:owner)
    @company = companies(:one)
    refute_permit owner, @company, :create
  end

  test "user with owner permission on its organization can create a company record" do
    owner = users(:owner)
    owner.organization.grant_permission_to "owner", owner
    @company = companies(:one)
    assert_permit owner, @company, :create
  end

  def test_update; end

  def test_destroy; end
end
