class SongTitlesController < ApplicationController
  # GET /song_titles or /song_titles.json
  def index
    @song_titles = SongTitle.all
  end

  # GET /song_titles/1 or /song_titles/1.json
  def show
    @song_title = SongTitle.find(params[:id])
  end
end
