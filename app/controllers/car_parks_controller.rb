class CarParksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_car_park, only: %i[edit update show destroy]

  def index
    if current_user&.owner_role?
      @car_parks = current_user.car_parks
      render 'owner_index'
    else
      @car_parks = CarPark.all
    end
  end

  def show; end

  def new
    @car_park = CarPark.new
  end

  def edit; end

  def create
    if CarParkServices::CarParkCreator.call(car_park_params)
      redirect_to car_parks_path, notice: 'Car park was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if CarParkServices::CarParkUpdater.call(car_park_params, @car_park)
      redirect_to car_park_path(@car_park), notice: 'Car park was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    CarParkServices::CarParkRemover.call(@car_park)
    redirect_to car_parks_url, notice: 'Car park was successfully destroyed.'
  end

  private

  def set_car_park
    @car_park = CarParkServices::CarParkFinder.call(params[:id])
  end

  def car_park_params
    params.require(:car_park).permit(:title, :address, :parking_type, :usage_fee, :discount,
                                     :spaces).merge(user_id: current_user.id)
  end
end
