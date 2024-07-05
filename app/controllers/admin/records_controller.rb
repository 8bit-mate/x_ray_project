class Admin::RecordsController < ApplicationController
  include AdministrableController

  before_action :set_record, only: %i[show edit update destroy]

  # GET /records or /records.json
  def index
    @q = Record.all.ransack(params[:q], auth_object: :admin)
    @q.sorts = "id" if @q.sorts.blank?
    @pagy, @records = pagy(@q.result, items: 50, anchor_string: 'data-turbo-stream="true"')
  end

  # GET /records/1 or /records/1.json
  def show; end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit; end

  # POST /records or /records.json
  def create
    @record = Record.new(record_params)

    @record.tags_attributes = tags_params
    @record.create_or_update_tags

    respond_to do |format|
      if @record.save
        format.html { redirect_to admin_record_url(@record), notice: "Record was successfully created." }
        format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1 or /records/1.json
  def update
    @record.tags_attributes = tags_params
    @record.create_or_update_tags

    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to admin_record_url(@record), notice: "Record was successfully updated." }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1 or /records/1.json
  def destroy
    @record.destroy!

    respond_to do |format|
      format.html { redirect_to admin_records_url, notice: "Record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = Record.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def record_params
    params.require(:record).permit(
      :category_id,
      :label_id,
      :tech_info,
      :format_size,
      web_images: []
    )
  end

  def tags_params
    params.fetch(:tags, {}).permit(
      format_tags_ids: [],
      tracks_ids: []
    )
  end
end
