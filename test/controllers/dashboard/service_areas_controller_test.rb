# frozen_string_literal: true

require "test_helper"

module Dashboard
  class ServiceAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_area = service_areas(:one)
  end

  test "should get index" do
    get dashboard_service_areas_url
    assert_response :success
  end

  test "should get new" do
    get new_dashboard_service_area_url
    assert_response :success
  end

  test "should create service_area" do
    assert_difference("ServiceArea.count") do
      post dashboard_service_areas_url,
           params: { service_area: { boundary: @service_area.boundary, name: @service_area.name,
                                     status: @service_area.status } }
    end

    assert_redirected_to dashboard_service_area_url(ServiceArea.last)
  end

  test "should show service_area" do
    get dashboard_service_area_url(@service_area)
    assert_response :success
  end

  test "should get edit" do
    get edit_dashboard_service_area_url(@service_area)
    assert_response :success
  end

  test "should update service_area" do
    patch dashboard_service_area_url(@service_area),
          params: { service_area: { boundary: @service_area.boundary, name: @service_area.name,
                                    status: @service_area.status } }
    assert_redirected_to dashboard_service_area_url(@service_area)
  end

  test "should destroy service_area" do
    assert_difference("ServiceArea.count", -1) do
      delete dashboard_service_area_url(@service_area)
    end

    assert_redirected_to dashboard_service_areas_url
  end
  end
end
