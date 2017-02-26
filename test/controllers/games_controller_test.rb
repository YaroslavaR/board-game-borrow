require 'test_helper'
# Class responsible for games testing
class GamesControllerTest < ActionDispatch::IntegrationTest#ActionController::TestCase
#     games GET    /games(.:format)               games#index
#           POST   /games(.:format)               games#create
#  new_game GET    /games/new(.:format)           games#new
# edit_game GET    /games/:id/edit(.:format)      games#edit
#      game GET    /games/:id(.:format)           games#show
#           PATCH  /games/:id(.:format)           games#update
#           PUT    /games/:id(.:format)           games#update
#           DELETE /games/:id(.:format)           games#destroy

  setup do
    @game = games(:one)
    @user = users(:three)
    sign_in @user
  end

  test "should get index" do
    get games_path
    assert_response :success
  end

  test "should get new" do
    get new_game_path
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post games_path,
        params: 
          { 
            game: 
              {
              	id: @game.id,
  				title: @game.title,
  				min_players: @game.min_players,
  				max_players: @game.max_players,
  				playing_time: @game.playing_time,
  				complexity: @game.complexity,
  				location: @game.location,
  				rating: @game.rating,
  				link: @game.link
              } 
          }
    end

    assert_redirected_to game_path(Game.last)
  end

  test "should show game" do
    get games_path(@game)
    assert_response :success
  end

  test "should get edit" do
  	get edit_game_path(@game)
    assert_response :success
  end

  test "should edit game" do
   put game_path(@game.id), params: 
    			{ 
    				game: 
    					{ 
    						title: "Title"
  						} 
  				}
  	@game.reload
  	assert_equal "Title", @game.title
  	assert_equal 3.0, @game.rating
  end

  test "should change is_deleted on game" do
    assert_difference('Game.count', 0) do
      delete game_path(@game)
    end
    @game.reload
    assert @game.is_deleted == 1
    assert_redirected_to games_path

  end
end
