class PreferencesController < ApplicationController
  include AuthenticateController

  before_action :authenticate_user, only: %i[index]

  def index
    @cookies = cookies
  end

  def update
    GuestPreferenceService.update_guest_preferences(cookies, preferences_params)

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  private

  def preferences_params
    if user_signed_in?
      # Logged-in users have access to all preferences.
      params.require(:preferences).permit(
        :language,
        :theme
      )
    else
      # Guests have access to a limited set of preferences.
      params.require(:preferences).permit(
        :language
      )
    end
  end
end
