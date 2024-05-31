class CategoriesController < ApplicationController
  # GET /categories or /categories.json
  def index
    @categories = Category.visible
  end

  # GET /categories/1 or /categories/1.json
  def show
    @category = Category.visible.friendly.find(params[:id])
    @pagy, @records = pagy_array(
      @category.records,
      items: Rails.application.config.pagy_n_items
    )
  end
end
