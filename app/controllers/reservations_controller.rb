class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[edit update show destroy]
  before_action :set_car_park, only: %i[new create owner_index]

  def new
    @reservation = Reservation.new
  end

  def owner_index
    @reservations = @car_park.reservations
  end

  def index
    if current_user&.owner_role?
      # @current_reservations = current_user.reservations.current_reservations
    else
      @current_reservations = current_user.reservations.current_reservations
      @past_reservations = current_user.reservations.past_reservations
    end
  end

  def show; end

  def edit; end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.car_park_id = params[:ar_car_park_id]

    if @reservation.save
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @reservation.car_park_id = @reservation.car_park.id
    if @reservation.update(reservation_params)
      redirect_to reservations_path
      flash[:success] = 'Reservation was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservation_path
    flash[:success] = 'Reservation was successfully destroyed'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_car_park
    @car_park = CarPark::Finder.call(params[:ar_car_park_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
