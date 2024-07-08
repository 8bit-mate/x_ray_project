class Admin::CategoriesController < ApplicationController
  include AdministrableController
  include TagWithImageController

  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories or /categories.json
  def index
    @q = Category.all
                 .includes(%i[image_attachment])
                 .ransack(params[:q], auth_object: :admin)
    @q.sorts = "id" if @q.sorts.blank?
    @pagy, @categories = pagy(@q.result, items: 50, anchor_string: 'data-turbo-stream="true"')
  end

  # GET /categories/1 or /categories/1.json
  def show; end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /categories or /categories.json
  def create
    @category = Category.new(tag_params(:category))

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_category_url(@category), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(tag_params(:category))
        format.html { redirect_to admin_category_url(@category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.friendly.find(params[:id])
  end
end
