class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  def current_user
    super&.decorate
  end
end
