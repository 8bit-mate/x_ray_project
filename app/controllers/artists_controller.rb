class ArtistsController < ApplicationController
  # GET /artists or /artists.json
  def index
    @artists = Artist.all
  end

  # GET /artists/1 or /artists/1.json
  def show
    @artist = Artist.friendly.find(params[:id])
  end
end
