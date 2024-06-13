class Admin::LabelsController < ApplicationController
  include AdministrableController
  include TagWithImageController

  before_action :set_label, only: %i[show edit update destroy]

  # GET /labels or /labels.json
  def index
    @labels = Label.all
  end

  # GET /labels/1 or /labels/1.json
  def show; end

  # GET /labels/new
  def new
    @label = Label.new
  end

  # GET /labels/1/edit
  def edit; end

  # POST /labels or /labels.json
  def create
    @label = Label.new(tag_params(:label))

    respond_to do |format|
      if @label.save
        format.html { redirect_to admin_label_url(@label), notice: "Label was successfully created." }
        format.json { render :show, status: :created, location: @label }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labels/1 or /labels/1.json
  def update
    respond_to do |format|
      if @label.update(tag_params(:label))
        format.html { redirect_to admin_label_url(@label), notice: "Label was successfully updated." }
        format.json { render :show, status: :ok, location: @label }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labels/1 or /labels/1.json
  def destroy
    @label.destroy!

    respond_to do |format|
      format.html { redirect_to admin_labels_url, notice: "Label was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def tag_params(tag_name)
    params.require(tag_name).permit(
      :name_en,
      :name_ru,
      :short_description_en,
      :short_description_ru,
      :description_en,
      :description_ru,
      :visible,
      :image,
      :parent_label_id
    )
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_label
    @label = Label.friendly.find(params[:id])
  end
end
