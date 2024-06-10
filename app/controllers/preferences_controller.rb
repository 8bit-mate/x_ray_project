class PreferencesController < ApplicationController
  include AuthenticateController

  before_action :authenticate_user, only: %i[index]

  def index
    @cookies = cookies
  end

  def update
    if user_signed_in?
      update_user_preferences
    else
      update_guest_preferences
    end
  end

  private

  def update_user_preferences
    current_user.update_preference(preferences_params)

    respond_to do |format|
      format.html { redirect_to request.path }
    end
  end

  def update_guest_preferences
    GuestPreferenceService.update_guest_preferences(cookies, preferences_params)

    respond_to do |format|
      format.html { redirect_to request.path }
    end
  end

  def preferences_params
    if user_signed_in?
      # Logged-in users have access to all preferences.
      params.require(:preferences).permit(
        :language
      )
    else
      # Guests have access to a limited set of preferences.
      params.require(:preferences).permit(
        :language
      )
    end
  end
end
