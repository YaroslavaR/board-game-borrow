# Class responsible for processing requests and generating responses for rentals
class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /rentals
  # Get all rentals sorted by creation date
  def index
    @rentals = Rental.get_all
  end

  # Get all rentals for current user
  def my_rentals
    @rentals = Rental.get_all_for_user current_user
  end

  # GET /rentals/1
  # Get rental by id
  def show
    @rental = Rental.get_by_id(params[:id])
  end

  # GET /rentals/new
  # Render new rental view
  def new
    @rental = current_user.rental.build
    @date = params[:date]
    @game_id = params[:game_id]
  end

  # GET /rentals/1/edit
  # Edit existing rental
  def edit
  end

  # POST /rentals
  # Create new rental
  def create
    @rental = current_user.rental.build(rental_params)
    @rental.end_time = @rental.start_time


    date = Date.new(rental_params['start_time(1i)'].to_i, rental_params['start_time(2i)'].to_i, rental_params['start_time(3i)'].to_i)
    
    @existing_rental = Rental.get_non_vetoed_for(rental_params[:game_id], date)
    @user_rentals = Rental.get_for_user_and_date(current_user, date)
    
    if !@existing_rental.nil?
      if !@existing_rental.is_optional?
        flash[:alert] = "You can't rent this game because it is rented for that day already."
        redirect_to :back
        return
      elsif !@user_rentals.nil? && has_guaranteed_rental(@user_rentals)
        flash[:alert] = "You can't rent this game because it is rented as optional and you have a guaranteed rental for that day already."
        redirect_to :back
        return
      else
        @message = "This game was rented as optional by #{@existing_rental.user.email} but you have vetoed it and rented that game."
        @existing_rental.is_vetoed = current_user.id
        @existing_rental.save
      end
    elsif !@user_rentals.nil? && has_guaranteed_rental(@user_rentals)
      @message = 'You have rented this game as optional. Please check again after 3pm to see if no one vetoed it.'
      @optional = true
    else
      @message = 'You have rented this game. Your reservation is guaranteed.'
    end

    respond_to do |format|
      @rental.is_optional = 1 if @optional == true
      if @rental.save
        format.html { redirect_to @rental, notice: @message }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1
  # Delete reservation
  def destroy
    @rental.destroy
    respond_to do |format|
      format.html { redirect_to rentals_url, notice: 'Rental was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.get_by_id(params[:id])
    end

    # Allowed and required parameters for rental creation/edition
    def rental_params
      params.require(:rental).permit(:name, :start_time, :end_time, :game_id, :is_optional)
    end

    # Check if user has a guaranteed rental already
    def has_guaranteed_rental(rentals)
      rentals.each do |r|
        if !r.is_optional?
          return true
        end
      end
      false
    end

end
