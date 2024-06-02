module ApplicationHelper
  include Pagy::Frontend

  def sort_button_class(sort_field, sort_order, mode)
    "#{sort_field}_#{sort_order}" == mode ? "dropdown-item active" : "dropdown-item"
  end
end
