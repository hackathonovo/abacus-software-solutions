require 'test_helper'

class OwnInvitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get own_invites_index_url
    assert_response :success
  end

end
