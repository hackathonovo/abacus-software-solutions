require 'test_helper'

class InvitesControllerTest < ActionController::TestCase
  setup do
    @rescue_action = rescue_actions(:one)
    @invite = invites(:one)
  end

  test "should get index" do
    get :index, params: { rescue_action_id: @rescue_action }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { rescue_action_id: @rescue_action }
    assert_response :success
  end

  test "should create invite" do
    assert_difference('Invite.count') do
      post :create, params: { rescue_action_id: @rescue_action, invite: @invite.attributes }
    end

    assert_redirected_to rescue_action_invite_path(@rescue_action, Invite.last)
  end

  test "should show invite" do
    get :show, params: { rescue_action_id: @rescue_action, id: @invite }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { rescue_action_id: @rescue_action, id: @invite }
    assert_response :success
  end

  test "should update invite" do
    put :update, params: { rescue_action_id: @rescue_action, id: @invite, invite: @invite.attributes }
    assert_redirected_to rescue_action_invite_path(@rescue_action, Invite.last)
  end

  test "should destroy invite" do
    assert_difference('Invite.count', -1) do
      delete :destroy, params: { rescue_action_id: @rescue_action, id: @invite }
    end

    assert_redirected_to rescue_action_invites_path(@rescue_action)
  end
end
