class SongGroupsController < ApplicationController
  # GET /song_groups or /song_groups.json
  def index
    @q = SongGroup.all.ransack(params[:q])
    @q.sorts = "title" if @q.sorts.blank?
    @pagy, @song_groups = pagy(@q.result, anchor_string: 'data-turbo-stream="true"')
  end

  # GET /song_groups/1 or /song_groups/1.json
  def show
    @song_group = SongGroup.find(params[:id])
  end
end
