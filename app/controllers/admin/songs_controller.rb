class Admin::SongsController < ApplicationController
  include AdministrableController

  before_action :set_song, only: %i[show edit update destroy]

  # GET /songs or /songs.json
  def index
    @q = Song.all.ransack(params[:q], auth_object: :admin)
    @q.sorts = "id" if @q.sorts.blank?
    @pagy, @songs = pagy(@q.result, items: 50, anchor_string: 'data-turbo-stream="true"')
  end

  # https://stackoverflow.com/questions/71713303/rails-7-dynamic-nested-forms-with-hotwire-turbo-frames
  def add_artist
    helpers.fields model: Song.new do |f|
      f.fields_for :artist_songs, ArtistSong.new,
                   child_index: Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond) do |ff|
        render turbo_stream: turbo_stream.append(
          "artist_songs",
          partial: "artist_songs_fields",
          locals: { f: ff }
        )
      end
    end
  end

  # GET /songs/1 or /songs/1.json
  def show; end

  # GET /songs/new
  def new
    @song = Song.new
    @song.artist_songs.build
  end

  # GET /songs/1/edit
  def edit; end

  # POST /songs or /songs.json
  def create
    @song = Song.new(song_params)
    @song.create_or_update_main_artist(song_params)

    respond_to do |format|
      if @song.save
        @song.update_full_title
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
    @song.create_or_update_main_artist(song_params)

    respond_to do |format|
      if @song.update(song_params)
        @song.update_full_title
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
      :song_group_id,
      :title_en,
      :title_ru,
      :year_of_release,
      :variation_en,
      :variation_ru,
      :notes_en,
      :notes_ru,
      artist_songs_attributes: %i[id artist_id role_en role_ru _destroy]
    )
  end
end
