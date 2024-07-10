module PostsHelper
  def tab_status(locale)
    I18n.locale == locale ? "show active" : ""
  end

  def nav_link_status(locale)
    I18n.locale == locale ? "active" : ""
  end
end
