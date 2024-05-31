class ArtistsController < ApplicationController
  # GET /artists or /artists.json
  def index
    @artists = Artist.all
  end

  # GET /artists/1 or /artists/1.json
  def show
    @artist = Artist.friendly.find(params[:id])

    @pagy_for_songs, @songs = pagy_array(
      @artist.songs.sort_by_title,
      items: Rails.application.config.pagy_n_items_mini,
      page_param: "songs_page"
    )

    @pagy_for_records, @records = pagy_array(
      @artist.records,
      items: Rails.application.config.pagy_n_items_mini,
      page_param: "records_page"
    )
  end
end
