class Admin::SongTitlesController < ApplicationController
  include AdministrableController

  before_action :set_song_title, only: %i[show edit update destroy]

  # GET /song_titles or /song_titles.json
  def index
    @song_titles = SongTitle.all
  end

  # GET /song_titles/1 or /song_titles/1.json
  def show; end

  # GET /song_titles/new
  def new
    @song_title = SongTitle.new
  end

  # GET /song_titles/1/edit
  def edit; end

  # POST /song_titles or /song_titles.json
  def create
    @song_title = SongTitle.new(song_title_params)

    respond_to do |format|
      if @song_title.save
        format.html { redirect_to admin_song_title_url(@song_title), notice: "Song title was successfully created." }
        format.json { render :show, status: :created, location: @song_title }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /song_titles/1 or /song_titles/1.json
  def update
    respond_to do |format|
      if @song_title.update(song_title_params)
        format.html { redirect_to admin_song_title_url(@song_title), notice: "Song title was successfully updated." }
        format.json { render :show, status: :ok, location: @song_title }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /song_titles/1 or /song_titles/1.json
  def destroy
    @song_title.destroy!

    respond_to do |format|
      format.html { redirect_to admin_song_titles_url, notice: "Song title was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song_title
    @song_title = SongTitle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def song_title_params
    params.require(:song_title).permit(
      :title_en,
      :title_ru
    )
  end
end
