module CarPark
  class Creator < ApplicationService
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def call
      create_park_park
    end

    private

    def create_park_park
      Ar::CarPark.new(attributes).save
    end
  end
end
