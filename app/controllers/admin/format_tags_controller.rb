class Admin::FormatTagsController < ApplicationController
  include AdministrableController
  include TagController

  before_action :set_format_tag, only: %i[show edit update destroy]

  # GET /format_tags or /format_tags.json
  def index
    @format_tags = FormatTag.all
  end

  # GET /format_tags/1 or /format_tags/1.json
  def show; end

  # GET /format_tags/new
  def new
    @format_tag = FormatTag.new
  end

  # GET /format_tags/1/edit
  def edit; end

  # POST /format_tags or /format_tags.json
  def create
    @format_tag = FormatTag.new(tag_params(:format_tag))

    respond_to do |format|
      if @format_tag.save
        format.html { redirect_to admin_format_tag_url(@format_tag), notice: "Format tag was successfully created." }
        format.json { render :show, status: :created, location: @format_tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @format_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /format_tags/1 or /format_tags/1.json
  def update
    respond_to do |format|
      if @format_tag.update(tag_params(:format_tag))
        format.html { redirect_to admin_format_tag_url(@format_tag), notice: "Format tag was successfully updated." }
        format.json { render :show, status: :ok, location: @format_tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @format_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /format_tags/1 or /format_tags/1.json
  def destroy
    @format_tag.destroy!

    respond_to do |format|
      format.html { redirect_to admin_format_tags_url, notice: "Format tag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_format_tag
    @format_tag = FormatTag.friendly.find(params[:id])
  end
end
