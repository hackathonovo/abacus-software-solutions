require 'test_helper'

class FeedItemsControllerTest < ActionController::TestCase
  setup do
    @rescue_action = rescue_actions(:one)
    @feed_item = feed_items(:one)
  end

  test "should get index" do
    get :index, params: { rescue_action_id: @rescue_action }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { rescue_action_id: @rescue_action }
    assert_response :success
  end

  test "should create feed_item" do
    assert_difference('FeedItem.count') do
      post :create, params: { rescue_action_id: @rescue_action, feed_item: @feed_item.attributes }
    end

    assert_redirected_to rescue_action_feed_item_path(@rescue_action, FeedItem.last)
  end

  test "should show feed_item" do
    get :show, params: { rescue_action_id: @rescue_action, id: @feed_item }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { rescue_action_id: @rescue_action, id: @feed_item }
    assert_response :success
  end

  test "should update feed_item" do
    put :update, params: { rescue_action_id: @rescue_action, id: @feed_item, feed_item: @feed_item.attributes }
    assert_redirected_to rescue_action_feed_item_path(@rescue_action, FeedItem.last)
  end

  test "should destroy feed_item" do
    assert_difference('FeedItem.count', -1) do
      delete :destroy, params: { rescue_action_id: @rescue_action, id: @feed_item }
    end

    assert_redirected_to rescue_action_feed_items_path(@rescue_action)
  end
end
