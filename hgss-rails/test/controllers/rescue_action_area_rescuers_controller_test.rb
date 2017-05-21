require 'test_helper'

class RescueActionAreaRescuersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rescue_action_area_rescuer = rescue_action_area_rescuers(:one)
  end

  test "should get index" do
    get rescue_action_area_rescuers_url
    assert_response :success
  end

  test "should get new" do
    get new_rescue_action_area_rescuer_url
    assert_response :success
  end

  test "should create rescue_action_area_rescuer" do
    assert_difference('RescueActionAreaRescuer.count') do
      post rescue_action_area_rescuers_url, params: { rescue_action_area_rescuer: {  } }
    end

    assert_redirected_to rescue_action_area_rescuer_url(RescueActionAreaRescuer.last)
  end

  test "should show rescue_action_area_rescuer" do
    get rescue_action_area_rescuer_url(@rescue_action_area_rescuer)
    assert_response :success
  end

  test "should get edit" do
    get edit_rescue_action_area_rescuer_url(@rescue_action_area_rescuer)
    assert_response :success
  end

  test "should update rescue_action_area_rescuer" do
    patch rescue_action_area_rescuer_url(@rescue_action_area_rescuer), params: { rescue_action_area_rescuer: {  } }
    assert_redirected_to rescue_action_area_rescuer_url(@rescue_action_area_rescuer)
  end

  test "should destroy rescue_action_area_rescuer" do
    assert_difference('RescueActionAreaRescuer.count', -1) do
      delete rescue_action_area_rescuer_url(@rescue_action_area_rescuer)
    end

    assert_redirected_to rescue_action_area_rescuers_url
  end
end
