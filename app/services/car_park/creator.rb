module CarPark
  class Creator < ApplicationService
    attr_reader :car_park

    def initialize(car_park)
      @car_park = car_park
    end

    def call
      create
    end

    private

    def create
      car_park.save
    end
  end
end
