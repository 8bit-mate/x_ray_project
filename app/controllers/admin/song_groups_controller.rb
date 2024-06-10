class Admin::SongGroupsController < ApplicationController
  include AdministrableController

  before_action :set_song_group, only: %i[show edit update destroy]

  # GET /song_groups or /song_groups.json
  def index
    @song_groups = SongGroup.all
  end

  # GET /song_groups/1 or /song_groups/1.json
  def show; end

  # GET /song_groups/new
  def new
    @song_group = SongGroup.new
  end

  # GET /song_groups/1/edit
  def edit; end

  # POST /song_groups or /song_groups.json
  def create
    @song_group = SongGroup.new(song_group_params)

    respond_to do |format|
      if @song_group.save
        format.html { redirect_to admin_song_group_url(@song_group), notice: "Song group was successfully created." }
        format.json { render :show, status: :created, location: @song_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /song_groups/1 or /song_groups/1.json
  def update
    respond_to do |format|
      if @song_group.update(song_group_params)
        format.html { redirect_to admin_song_group_url(@song_group), notice: "Song group was successfully updated." }
        format.json { render :show, status: :ok, location: @song_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /song_groups/1 or /song_groups/1.json
  def destroy
    @song_group.destroy!

    respond_to do |format|
      format.html { redirect_to admin_song_groups_url, notice: "Song group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song_group
    @song_group = SongGroup.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def song_group_params
    params.require(:song_group).permit(
      :title_en,
      :title_ru
    )
  end
end
