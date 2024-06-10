class FormatTagsController < ApplicationController
  # GET /format_tags or /format_tags.json
  def index
    @q = FormatTag.visible.ransack(params[:q])
    @q.sorts = "name" if @q.sorts.blank?
    @pagy, @format_tags = pagy(@q.result)
  end

  # GET /format_tags/1 or /format_tags/1.json
  def show
    @format_tag = FormatTag.visible.friendly.find(params[:id])
  end
end
