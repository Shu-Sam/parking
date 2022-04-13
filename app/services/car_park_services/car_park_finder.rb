module CarParkServices
  class CarParkFinder < ApplicationService
    attr_reader :car_park_id

    def initialize(car_park_id)
      @car_park_id = car_park_id
    end

    def call
      set_car_park
    end

    private

    def set_car_park
      CarPark.find(car_park_id)
    end
  end
end
