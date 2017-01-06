class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /rentals
  # GET /rentals.json
  def index
    @rentals = Rental.all
  end

  # GET /rentals/1
  # GET /rentals/1.json
  def show
    @rental = Rental.find(params[:id])
  end

  # GET /rentals/new
  def new
    @rental = current_user.rental.build
    @date = params[:date]
    @game_id = params[:game_id]
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals
  # POST /rentals.json
  def create
    @rental = current_user.rental.build(rental_params)

    respond_to do |format|
      if @rental.save
        format.html { redirect_to @rental, notice: 'Rental was successfully created.' }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1
  # PATCH/PUT /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to @rental, notice: 'Rental was successfully updated.' }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1
  # DELETE /rentals/1.json
  def destroy
    @rental.destroy
    respond_to do |format|
      format.html { redirect_to rentals_url, notice: 'Rental was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_rentals
    @rentals = current_user.rental
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_params
      params.require(:rental).permit(:name, :start_time, :end_time, :game_id, :is_optional)
    end
end
