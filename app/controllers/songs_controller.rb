class SongsController < ApplicationController
  # GET /songs or /songs.json
  def index
    @pagy, @songs = pagy(
      Song.sort_by_title,
      items: Rails.application.config.pagy_n_items
    )
  end

  # GET /songs/1 or /songs/1.json
  def show
    @song = Song.friendly.find(params[:id])

    @pagy_for_songs, @other_variations = pagy_array(
      @song.other_variations,
      items: Rails.application.config.pagy_n_items_mini,
      page_param: "songs_page"
    )

    @pagy_for_records, @records = pagy_array(
      @song.records,
      items: Rails.application.config.pagy_n_items_mini,
      page_param: "records_page"
    )
  end
end
