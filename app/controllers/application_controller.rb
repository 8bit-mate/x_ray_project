class ApplicationController < ActionController::Base
  before_action :set_locale

  # https://learn.microsoft.com/en-us/graph/search-concept-acceptlanguage-header
  CYR_LANGS = %w[ru be uk bg kk ky mn sr tg tk tt uz].freeze

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to login_path, notice: "Please log in!"
    end
  end

  def set_locale
    I18n.locale = extract_locale
  end

  def extract_locale
    if user_signed_in?
      extract_locale_from_user
    else
      extract_locale_from_guest
    end
  end

  def extract_locale_from_user
    current_user.preference.language
  end

  def extract_locale_from_guest
    cookie_locale = GuestPreferenceService.get_preference(cookies, :language)

    # Case #1: there's no locale key in the cookies, i.e. a fresh visit just happened.
    return choose_locale_by_accept_language_header unless cookie_locale

    if I18n.available_locales.include?(cookie_locale.to_sym)
      # Case #2: there's a locale key in the cookies, and the value is a supported locale.
      cookie_locale
    else
      # Case #3: there's a locale key in the cookies, but the value is invalid.
      choose_locale_by_accept_language_header
    end
  end

  def choose_locale_by_accept_language_header
    locale = request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first

    CYR_LANGS.include?(locale) ? :ru : :en
  end

  # def set_default_locale
  #   preferences_params = {
  #     language: I18n.default_locale
  #   }

  #   GuestPreferenceService.update_guest_preferences(cookies, preferences_params)
  # end
end
