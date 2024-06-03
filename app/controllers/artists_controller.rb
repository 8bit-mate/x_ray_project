class ArtistsController < ApplicationController
  # GET /artists or /artists.json
  def index
    # @artists = Artist.all

    @q = Artist.all.ransack(params[:q])
    @q.sorts = "last_name" if @q.sorts.blank?
    @pagy, @artists = pagy(@q.result)
  end

  # GET /artists/1 or /artists/1.json
  def show
    @artist = Artist.friendly.find(params[:id])
  end
end
