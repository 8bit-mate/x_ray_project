class SongTitlesController < ApplicationController
  # GET /song_titles or /song_titles.json
  def index
    # @song_titles = SongTitle.all

    @q = SongTitle.all.ransack(params[:q])
    @q.sorts = "title" if @q.sorts.blank?
    @pagy, @song_titles = pagy(@q.result, anchor_string: 'data-turbo-stream="true"')
  end

  # GET /song_titles/1 or /song_titles/1.json
  def show
    @song_title = SongTitle.find(params[:id])
  end
end
