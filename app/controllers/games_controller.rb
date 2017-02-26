# Class responsible for processing requests and generating responses for games
class GamesController < ApplicationController
  before_action :set_rentals
  before_action :authenticate_user!, except: [:index, :show]
  before_action :verify_is_admin, except: [:index, :show]


 # Get all games that are not deleted
  def index
    @games = Game.get_all_active
  end  

  # Render new game view
  def new
    @game = Game.new
  end
 
  # Edit existing game
  def edit
    @game = Game.find(params[:id])
  end
 
  # Create new game 
  def create
    @game = Game.new(game_params)
    @game.is_deleted = 0
    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end
  
  # Show one game
  def show
    @game = Game.find(params[:id])
  end

  # Update data for a game
  def update
    @game = Game.find(params[:id])
 
    if @game.update(game_params)
      redirect_to @game
    else
      render 'edit'
    end
  end

  # Mark game as is_deleted
  def destroy
    @game = Game.find(params[:id])
    @game.is_deleted = 1
    @game.save
    redirect_to games_path
  end

  # Allowed and required parameters during game creation/edition
  private def game_params
    params.require(:game).permit(:title, :min_players, :max_players, :min_player_age, :rating, :playing_time, :complexity, :location, :link, :expansion_for)
  end

  # Verifying if the current user has admin privileges
  private def verify_is_admin
    (current_user.nil?) ? redirect_to(games_path) : (redirect_to(games_path) unless current_user.is_admin?)
  end

  # Get all rentals
  def set_rentals
    @rentals = Rental.all
  end
end
