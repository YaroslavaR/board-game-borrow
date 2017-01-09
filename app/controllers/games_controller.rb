class GamesController < ApplicationController
  before_action :set_rentals
  before_action :authenticate_user!, except: [:index, :show]
  #http_basic_authenticate_with name: "admin", password: "secret", except: [:index, :show]

  def index
    @games = Game.where(is_deleted: 0)
  end  

  def new
    @game = Game.new
  end
 
  def edit
    @game = Game.find(params[:id])
  end
 
  def create
    @game = Game.new(game_params)
    @game.is_deleted = 0
    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end
  
  def show
    @game = Game.find(params[:id])
    #render template: "rentals/index"
  end

  def update
    @game = Game.find(params[:id])
 
    if @game.update(game_params)
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.is_deleted = 1
    @game.save
    redirect_to games_path
  end

  private def game_params
    params.require(:game).permit(:title, :min_players, :max_players, :min_player_age, :rating, :playing_time, :complexity, :location, :link, :expansion_for)
  end

  def set_rentals
    @rentals = Rental.all
  end
end
