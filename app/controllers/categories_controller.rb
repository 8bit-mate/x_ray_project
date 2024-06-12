class CategoriesController < ApplicationController
  # GET /categories or /categories.json
  def index
    @categories = Category.visible.with_records
  end

  # GET /categories/1 or /categories/1.json
  def show
    @category = Category.visible.friendly.find(params[:id])
  end
end
