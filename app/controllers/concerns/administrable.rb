module Administrable
  extend ActiveSupport::Concern

  included do
    before_action :require_admin
  end

  private

  def admin? = current_user.try(:admin?)

  def require_admin
    return if admin?

    flash[:error] = "You are not authorized to perform this action."
    redirect_to new_user_session_path
  end
end
