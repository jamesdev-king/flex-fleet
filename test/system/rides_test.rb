# frozen_string_literal: true

require "application_system_test_case"

class RidesTest < ApplicationSystemTestCase
  setup do
    @ride = rides(:one)
  end

  test "visiting the index" do
    visit rides_url
    assert_selector "h1", text: "Rides"
  end

  test "should create ride" do
    visit rides_url
    click_on "New ride"

    fill_in "Canceled at", with: @ride.canceled_at
    fill_in "Company", with: @ride.company_id
    fill_in "Completed at", with: @ride.completed_at
    fill_in "Customer", with: @ride.customer_id
    fill_in "Destination address", with: @ride.destination_address
    fill_in "Destination coordinate", with: @ride.destination_coordinate
    fill_in "Driver", with: @ride.driver_id
    fill_in "Estimates", with: @ride.estimates
    fill_in "Origin address", with: @ride.origin_address
    fill_in "Origin coordinate", with: @ride.origin_coordinate
    fill_in "Picked up at", with: @ride.picked_up_at
    fill_in "Queried at", with: @ride.queried_at
    fill_in "Requested at", with: @ride.requested_at
    click_on "Create Ride"

    assert_text "Ride was successfully created"
    click_on "Back"
  end

  test "should update Ride" do
    visit ride_url(@ride)
    click_on "Edit this ride", match: :first

    fill_in "Canceled at", with: @ride.canceled_at
    fill_in "Company", with: @ride.company_id
    fill_in "Completed at", with: @ride.completed_at
    fill_in "Customer", with: @ride.customer_id
    fill_in "Destination address", with: @ride.destination_address
    fill_in "Destination coordinate", with: @ride.destination_coordinate
    fill_in "Driver", with: @ride.driver_id
    fill_in "Estimates", with: @ride.estimates
    fill_in "Origin address", with: @ride.origin_address
    fill_in "Origin coordinate", with: @ride.origin_coordinate
    fill_in "Picked up at", with: @ride.picked_up_at
    fill_in "Queried at", with: @ride.queried_at
    fill_in "Requested at", with: @ride.requested_at
    click_on "Update Ride"

    assert_text "Ride was successfully updated"
    click_on "Back"
  end

  test "should destroy Ride" do
    visit ride_url(@ride)
    click_on "Destroy this ride", match: :first

    assert_text "Ride was successfully destroyed"
  end
end
