class GuestPreferenceService
  PREFERENCE_KEYS = %i[language].freeze

  def self.update_guest_preferences(cookies, preferences)
    preferences.each do |key, value|
      cookies.permanent[key] = value
    end
  end

  def self.delete_guest_preferences(cookies)
    PREFERENCE_KEYS.each do |key|
      cookies.delete(key)
    end
  end

  def self.guest_preferences_present?(cookies)
    PREFERENCE_KEYS.any? { |key| cookies[key].present? }
  end

  def self.get_preference(cookies, key)
    cookies.key?(key) ? cookies[key] : nil
  end
end
