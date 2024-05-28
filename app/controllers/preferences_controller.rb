class PreferencesController < ApplicationController
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
    params.require(:preferences).permit(
      :language,
      :theme
    )
  end
end
