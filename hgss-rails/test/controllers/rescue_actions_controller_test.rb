require 'test_helper'

class RescueActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rescue_action = rescue_actions(:one)
  end

  test "should get index" do
    get rescue_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_rescue_action_url
    assert_response :success
  end

  test "should create rescue_action" do
    assert_difference('RescueAction.count') do
      post rescue_actions_url, params: { rescue_action: { description: @rescue_action.description, kind: @rescue_action.kind, lead_id: @rescue_action.lead_id, start_position_latitude: @rescue_action.start_position_latitude, start_position_longitude: @rescue_action.start_position_longitude } }
    end

    assert_redirected_to rescue_action_url(RescueAction.last)
  end

  test "should show rescue_action" do
    get rescue_action_url(@rescue_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_rescue_action_url(@rescue_action)
    assert_response :success
  end

  test "should update rescue_action" do
    patch rescue_action_url(@rescue_action), params: { rescue_action: { description: @rescue_action.description, kind: @rescue_action.kind, lead_id: @rescue_action.lead_id, start_position_latitude: @rescue_action.start_position_latitude, start_position_longitude: @rescue_action.start_position_longitude } }
    assert_redirected_to rescue_action_url(@rescue_action)
  end

  test "should destroy rescue_action" do
    assert_difference('RescueAction.count', -1) do
      delete rescue_action_url(@rescue_action)
    end

    assert_redirected_to rescue_actions_url
  end
end
