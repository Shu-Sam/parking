class UserPresenter < ApplicationPresenter
  def user_roles
    @model.class.roles.keys.map do |role|
      [role.titleize, role]
    end
  end
end
