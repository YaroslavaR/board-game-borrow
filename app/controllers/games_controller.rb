class GamesController < ApplicationController
  
  http_basic_authenticate_with name: "admin", password: "secret", except: [:index, :show]

  def index
    @games = Game.all
  end  

  def new
    @game = Game.new
  end
 
  def edit
    @game = Game.find(params[:id])
  end
 
  def create
    @game = Game.new(game_params)
 
    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end
  
  def show
    @game = Game.find(params[:id])
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
    @game.destroy
 
    redirect_to games_path
  end

  private def game_params
    params.require(:game).permit(:title, :min_players, :max_players, :min_player_age, :max_player_age, :playing_time, :complexity, :location, :link)
  end
end
