module ApplicationHelper
  def item_index(index, pagy)
    1 + index + (pagy.page - 1) * pagy.items
  end

  def list_artists(artists, order = :last_name_first, url_scope: nil)
    return "" if artists.empty?

    artists.map do |artist|
      link_to [url_scope, artist] do
        artist.full_name(order)
      end
    end.join("; ")
  end
end
