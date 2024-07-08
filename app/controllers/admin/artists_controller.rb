class Admin::ArtistsController < ApplicationController
  include AdministrableController

  before_action :set_artist, only: %i[show edit update destroy]

  # GET /artists or /artists.json
  def index
    @q = Artist.all
               .includes([:aliases])
               .includes([:primary_artist])
               .ransack(params[:q], auth_object: :admin)
    @q.sorts = "id" if @q.sorts.blank?
    @pagy, @artists = pagy(@q.result, items: 50, anchor_string: 'data-turbo-stream="true"')
  end

  def add_band_member
    helpers.fields model: Artist.new do |f|
      f.fields_for :band_memberships, ArtistBand.new,
                   child_index: Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond) do |ff|
        render turbo_stream: turbo_stream.append(
          "band_memberships",
          partial: "artist_bands_fields",
          locals: { f: ff }
        )
      end
    end
  end

  # GET /artists/1 or /artists/1.json
  def show; end

  # GET /artists/new
  def new
    @artist = Artist.new
    @artist.band_memberships.build
  end

  # GET /artists/1/edit
  def edit; end

  # POST /artists or /artists.json
  def create
    @artist = Artist.new(artist_params)

    respond_to do |format|
      if @artist.save
        format.html { redirect_to admin_artist_url(@artist), notice: "Artist was successfully created." }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1 or /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to admin_artist_url(@artist), notice: "Artist was successfully updated." }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1 or /artists/1.json
  def destroy
    @artist.destroy!

    respond_to do |format|
      format.html { redirect_to admin_artists_url, notice: "Artist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_artist
    @artist = Artist.friendly.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(
      :stage_name_en,
      :stage_name_ru,
      :real_name_en,
      :real_name_ru,
      :short_description_en,
      :short_description_ru,
      :description_en,
      :description_ru,
      :primary_artist_id,
      band_memberships_attributes: %i[id artist_id member_id band_id role_en role_ru _destroy]
    )
  end
end
