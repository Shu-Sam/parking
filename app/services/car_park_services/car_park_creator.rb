module CarParkServices
  class CarParkCreator < ApplicationService
    attr_reader :car_park_params

    def initialize(car_park_params)
      @car_park_params = car_park_params
    end

    def call
      create_park_park
    end

    private

    def create_park_park
      CarPark.new(car_park_params).save
    end
  end
end
