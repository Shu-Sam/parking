module CarPark
  class Remover < ApplicationService
    attr_reader :car_park

    def initialize(car_park)
      @car_park = car_park
    end

    def call
      @car_park.destroy
    end
  end
end
