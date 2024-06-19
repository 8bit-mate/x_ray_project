class Admin::SongsController < ApplicationController
  include AdministrableController

  before_action :set_song, only: %i[show edit update destroy]

  # GET /songs or /songs.json
  def index
    @q = Song.all.ransack(params[:q], auth_object: :admin)
    @q.sorts = "id" if @q.sorts.blank?
    @pagy, @songs = pagy(@q.result, items: 50, anchor_string: 'data-turbo-stream="true"')
  end

  # GET /songs/1 or /songs/1.json
  def show; end

  # GET /songs/new
  def new
    @song = Song.new
    # @song.artist_songs.build
  end

  # GET /songs/1/edit
  def edit; end

  # POST /songs or /songs.json
  def create
    @song = Song.new(song_params)
    @song.create_tags(tags_params)
    @song.create_or_update_main_artist(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to admin_song_url(@song), notice: "Song was successfully created." }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    @song.update_tags(tags_params)
    @song.create_or_update_main_artist(song_params)

    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to admin_song_url(@song), notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song.destroy!

    respond_to do |format|
      format.html { redirect_to admin_songs_url, notice: "Song was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = Song.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def song_params
    params.require(:song).permit(
      :year_of_release,
      :variation_en,
      :variation_ru,
      :notes_en,
      :notes_ru,
      artist_songs_attributes: %i[id artist_id role_en role_ru _destroy]
    )
  end

  def tags_params
    params.require(:tags).permit(
      :song_group_id
    )
  end
end
