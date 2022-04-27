module CarParks
  class CommentsController < ApplicationController
    include Commentable

    before_action :set_commentable

    private

    def set_commentable
      @commentable = CarPark::Finder.call(params[:ar_car_park_id])
    end
  end
end
