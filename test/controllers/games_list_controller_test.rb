require 'test_helper'

class GamesListControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get games_list_list_url
    assert_response :success
  end

end
