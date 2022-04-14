module CarPark
  class Updater < ApplicationService
    attr_reader :attributes, :car_park

    def initialize(attributes, car_park)
      @attributes = attributes
      @car_park = car_park
    end

    def call
      update
    end

    private

    def update
      car_park.update(attributes)
    end
  end
end
