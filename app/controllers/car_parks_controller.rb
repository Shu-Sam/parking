class CarParksController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_car_park, only: %i[show edit update destroy]

  def index
    if authenticate_user! && current_user.owner_role?
      @car_parks = current_user.owned_car_parks
      render 'owner_index'
    else
      @car_parks = CarPark.all
      render 'driver_index'
    end
  end

  def show; end

  def new
    @car_park = CarPark.new
  end

  def edit; end

  def create
    @car_park = CarPark.new(car_park_params)
    @car_park.owner = current_user
    if @car_park.save
      redirect_to car_park_url(@car_park), notice: 'Car park was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @car_park.update(car_park_params)
      redirect_to car_park_url(@car_park), notice: 'Car park was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car_park.destroy
    redirect_to car_parks_url, notice: 'Car park was successfully destroyed.'
  end

  private

  def set_car_park
    @car_park = CarPark.find(params[:id])
  end

  def car_park_params
    params.require(:car_park).permit(:title, :address, :parking_type, :usage_fee, :discount, :spaces)
  end
end
