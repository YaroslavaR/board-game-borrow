class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /rentals
  # GET /rentals.json
  def index
    @rentals = Rental.all.sort_by(&:start_time).reverse
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
    # @rental.end_time = @rental.start_time
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals
  # POST /rentals.json
  # def create
  #   @rental = current_user.rental.build(rental_params)
  #   @rental.end_time = @rental.start_time

  #   respond_to do |format|
  #     if @rental.save
  #       format.html { redirect_to @rental, notice: 'Rental was successfully created.' }
  #       format.json { render :show, status: :created, location: @rental }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @rental.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    @rental = current_user.rental.build(rental_params)
    @rental.end_time = @rental.start_time


    date = Date.new(rental_params['start_time(1i)'].to_i, rental_params['start_time(2i)'].to_i, rental_params['start_time(3i)'].to_i)
    
    @existing_rental = Rental.find_by(game_id: rental_params[:game_id], start_time: date, is_vetoed: nil)
    puts '################################'
    puts @existing_rental
    puts '################################'
    @user_rentals = current_user.rental.where(start_time: date)
    puts '################################'
    puts @user_rentals
    puts '################################'
    
      #format.html { render :new }
      if !@existing_rental.nil?
        # There is a rental for that date
        if !@existing_rental.is_optional?
          # Existing rental is guaranteed
          flash[:alert] = "You can't rent this game because it is rented for that day already."
          redirect_to :back
        elsif !@user_rentals.nil? && has_guaranteed_rental(@user_rentals)
          flash[:alert] = "You can't rent this game because it is rented as optional and you have a guaranteed rental for that day already."
          redirect_to :back
        else
          #input form
          respond_to do |format|
            if @rental.save
              @existing_rental.is_vetoed = current_user.id
              @existing_rental.save
              format.html { redirect_to @rental, notice: "This game was rented as optional by #{@existing_rental.user.email} but you have vetoed it and rented that game." }
              format.json { render :show, status: :created, location: @rental }
            else
              format.html { render :new }
              format.json { render json: @rental.errors, status: :unprocessable_entity }
            end
          end
        end
      elsif !@user_rentals.nil? && has_guaranteed_rental(@user_rentals)
        #input form
        respond_to do |format|
          @rental.is_optional = 1
          if @rental.save
              format.html { redirect_to @rental, notice: 'You have rented this game as optional. Please check again after 3pm to see if no one vetoed it.' }
              format.json { render :show, status: :created, location: @rental }
          else
              format.html { render :new }
              format.json { render json: @rental.errors, status: :unprocessable_entity }
          end
        end
      else
        #input form
        respond_to do |format|
          if @rental.save
              format.html { redirect_to @rental, notice: 'You have rented this game. Your reservation is guaranteed.' }
              format.json { render :show, status: :created, location: @rental }
          else
              format.html { render :new }
              format.json { render json: @rental.errors, status: :unprocessable_entity }
          end
        end
      end
    
  end

  # def create
  #   @rental = current_user.rental.build(rental_params)
  #   @existing_rental = Rental.find_by(game_id: rental_params[:game_id], start_time: rental_params[:date])
  #   if !@existing_rental.nil? && @existing_rental.is_optional?
  #     @user_rentals = current_user.rental.find(rental_params[:date])
  #     if @user_rentals.nil?
        
  #       respond_to do |format|
  #         if @rental.save
  #           format.html { redirect_to @rental, notice: 'Rental was successfully created.' }
  #           format.json { render :show, status: :created, location: @rental }
  #         else
  #           format.html { render :new }
  #           format.json { render json: @rental.errors, status: :unprocessable_entity }
  #         end
  #       end
  #     end
        
  #       @user_rentals.each do |user_rentals|
  #         if !user_rental.is_optional?
  #         end
  #       end
  #     end
  #   end

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
    @rentals = current_user.rental.sort_by(&:start_time).reverse
    
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

    def has_guaranteed_rental(rentals)
      rentals.each do |r|
        if !r.is_optional?
          return true
        end
      end
      false
    end

end
