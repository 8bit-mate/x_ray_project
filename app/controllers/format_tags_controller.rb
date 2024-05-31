class FormatTagsController < ApplicationController
  # GET /format_tags or /format_tags.json
  def index
    @format_tags = FormatTag.visible
  end

  # GET /format_tags/1 or /format_tags/1.json
  def show
    @format_tag = FormatTag.visible.friendly.find(params[:id])

    @pagy, @records = pagy(
      @format_tag.records,
      items: Rails.application.config.pagy_n_items_mini,
      page_param: "songs_page"
    )
  end
end
