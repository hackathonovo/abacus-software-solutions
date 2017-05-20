require 'test_helper'

class RescuersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rescuer = rescuers(:one)
  end

  test "should get index" do
    get rescuers_url
    assert_response :success
  end

  test "should get new" do
    get new_rescuer_url
    assert_response :success
  end

  test "should create rescuer" do
    assert_difference('Rescuer.count') do
      post rescuers_url, params: { rescuer: { address_home: @rescuer.address_home, address_work: @rescuer.address_work, availability: @rescuer.availability, first_name: @rescuer.first_name, home_latitude: @rescuer.home_latitude, home_longitude: @rescuer.home_longitude, last_name: @rescuer.last_name, level: @rescuer.level, phone_number: @rescuer.phone_number, work_latitude: @rescuer.work_latitude, work_longitude: @rescuer.work_longitude } }
    end

    assert_redirected_to rescuer_url(Rescuer.last)
  end

  test "should show rescuer" do
    get rescuer_url(@rescuer)
    assert_response :success
  end

  test "should get edit" do
    get edit_rescuer_url(@rescuer)
    assert_response :success
  end

  test "should update rescuer" do
    patch rescuer_url(@rescuer), params: { rescuer: { address_home: @rescuer.address_home, address_work: @rescuer.address_work, availability: @rescuer.availability, first_name: @rescuer.first_name, home_latitude: @rescuer.home_latitude, home_longitude: @rescuer.home_longitude, last_name: @rescuer.last_name, level: @rescuer.level, phone_number: @rescuer.phone_number, work_latitude: @rescuer.work_latitude, work_longitude: @rescuer.work_longitude } }
    assert_redirected_to rescuer_url(@rescuer)
  end

  test "should destroy rescuer" do
    assert_difference('Rescuer.count', -1) do
      delete rescuer_url(@rescuer)
    end

    assert_redirected_to rescuers_url
  end
end
