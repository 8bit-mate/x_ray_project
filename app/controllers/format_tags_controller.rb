class FormatTagsController < ApplicationController
  # GET /format_tags or /format_tags.json
  def index
    @format_tags = FormatTag.all
  end

  # GET /format_tags/1 or /format_tags/1.json
  def show
    @format_tag = FormatTag.friendly.find(params[:id])
  end
end
