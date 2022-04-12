class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_user
    super&.decorate
  end

end
