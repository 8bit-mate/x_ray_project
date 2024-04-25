class SongsController < ApplicationController
  # GET /songs or /songs.json
  def index
    @songs = Song.all
  end

  # GET /songs/1 or /songs/1.json
  def show
    @song = Song.find(params[:id])
  end
end
