module ApplicationHelper
  def item_index(index, pagy)
    1 + index + (pagy.page - 1) * pagy.items
  end
end
