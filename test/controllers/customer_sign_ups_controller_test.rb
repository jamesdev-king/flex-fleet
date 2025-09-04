# frozen_string_literal: true

require "test_helper"

class CustomerSignUpsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get customer_sign_ups_new_url
    assert_response :success
  end

  test "should get create" do
    get customer_sign_ups_create_url
    assert_response :success
  end
end
