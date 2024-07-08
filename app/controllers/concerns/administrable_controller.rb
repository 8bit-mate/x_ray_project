module AdministrableController
  extend ActiveSupport::Concern

  included do
    before_action :require_admin
  end

  private

  def admin? = current_user.try(:admin?)

  def require_admin
    return if admin?

    redirect_to new_user_session_path, notice: "You are not authorized to perform this action."
  end
end
