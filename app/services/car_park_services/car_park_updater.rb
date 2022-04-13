module CarParkServices
  class CarParkUpdater < ApplicationService
    attr_reader :car_park_params, :car_park

    def initialize(car_park_params, car_park)
      @car_park_params = car_park_params
      @car_park = car_park
    end

    def call
      update
    end

    private

    def update
      car_park.update(car_park_params)
    end
  end
end
