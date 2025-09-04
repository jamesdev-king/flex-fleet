# frozen_string_literal: true

require "test_helper"

class RidesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ride = rides(:one)
  end

  test "should get index" do
    get rides_url
    assert_response :success
  end

  test "should get new" do
    get new_ride_url
    assert_response :success
  end

  test "should create ride" do
    assert_difference("Ride.count") do
      post rides_url,
           params: { ride: { canceled_at: @ride.canceled_at, company_id: @ride.company_id, completed_at: @ride.completed_at,
                             customer_id: @ride.customer_id, destination_address: @ride.destination_address, destination_coordinate: @ride.destination_coordinate, driver_id: @ride.driver_id, estimates: @ride.estimates, origin_address: @ride.origin_address, origin_coordinate: @ride.origin_coordinate, picked_up_at: @ride.picked_up_at, queried_at: @ride.queried_at, requested_at: @ride.requested_at } }
    end

    assert_redirected_to ride_url(Ride.last)
  end

  test "should show ride" do
    get ride_url(@ride)
    assert_response :success
  end

  test "should get edit" do
    get edit_ride_url(@ride)
    assert_response :success
  end

  test "should update ride" do
    patch ride_url(@ride),
          params: { ride: { canceled_at: @ride.canceled_at, company_id: @ride.company_id, completed_at: @ride.completed_at,
                            customer_id: @ride.customer_id, destination_address: @ride.destination_address, destination_coordinate: @ride.destination_coordinate, driver_id: @ride.driver_id, estimates: @ride.estimates, origin_address: @ride.origin_address, origin_coordinate: @ride.origin_coordinate, picked_up_at: @ride.picked_up_at, queried_at: @ride.queried_at, requested_at: @ride.requested_at } }
    assert_redirected_to ride_url(@ride)
  end

  test "should destroy ride" do
    assert_difference("Ride.count", -1) do
      delete ride_url(@ride)
    end

    assert_redirected_to rides_url
  end
end
