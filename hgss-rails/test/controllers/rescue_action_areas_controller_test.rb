require 'test_helper'

class RescueActionAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rescue_action_area = rescue_action_areas(:one)
  end

  test "should get index" do
    get rescue_action_areas_url
    assert_response :success
  end

  test "should get new" do
    get new_rescue_action_area_url
    assert_response :success
  end

  test "should create rescue_action_area" do
    assert_difference('RescueActionArea.count') do
      post rescue_action_areas_url, params: { rescue_action_area: { name: @rescue_action_area.name, rescue_action_id: @rescue_action_area.rescue_action_id } }
    end

    assert_redirected_to rescue_action_area_url(RescueActionArea.last)
  end

  test "should show rescue_action_area" do
    get rescue_action_area_url(@rescue_action_area)
    assert_response :success
  end

  test "should get edit" do
    get edit_rescue_action_area_url(@rescue_action_area)
    assert_response :success
  end

  test "should update rescue_action_area" do
    patch rescue_action_area_url(@rescue_action_area), params: { rescue_action_area: { name: @rescue_action_area.name, rescue_action_id: @rescue_action_area.rescue_action_id } }
    assert_redirected_to rescue_action_area_url(@rescue_action_area)
  end

  test "should destroy rescue_action_area" do
    assert_difference('RescueActionArea.count', -1) do
      delete rescue_action_area_url(@rescue_action_area)
    end

    assert_redirected_to rescue_action_areas_url
  end
end
