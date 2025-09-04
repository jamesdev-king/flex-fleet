# frozen_string_literal: true

require "application_system_test_case"

class ServiceAreasTest < ApplicationSystemTestCase
  setup do
    @service_area = service_areas(:one)
  end

  test "visiting the index" do
    visit service_areas_url
    assert_selector "h1", text: "Service areas"
  end

  test "should create service area" do
    visit service_areas_url
    click_on "New service area"

    fill_in "Boundary", with: @service_area.boundary
    fill_in "Name", with: @service_area.name
    fill_in "Status", with: @service_area.status
    click_on "Create Service area"

    assert_text "Service area was successfully created"
    click_on "Back"
  end

  test "should update Service area" do
    visit service_area_url(@service_area)
    click_on "Edit this service area", match: :first

    fill_in "Boundary", with: @service_area.boundary
    fill_in "Name", with: @service_area.name
    fill_in "Status", with: @service_area.status
    click_on "Update Service area"

    assert_text "Service area was successfully updated"
    click_on "Back"
  end

  test "should destroy Service area" do
    visit service_area_url(@service_area)
    click_on "Destroy this service area", match: :first

    assert_text "Service area was successfully destroyed"
  end
end
