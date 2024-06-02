class FormatTagsController < ApplicationController
  # GET /format_tags or /format_tags.json
  def index
    # @format_tags = FormatTag.visible

    @pagy, @format_tags = pagy(
      sort_items(FormatTag.visible),
      items: Rails.application.config.pagy_n_items
    )
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

  private

  def sort_items(items)
    if params[:sort_field] && params[:sort_order]
      sort_by_params(items)
    else
      default_order(items)
    end
  end

  def sort_by_params(items)
    valid_fields = %w[name]
    valid_orders = %w[asc desc]

    if valid_fields.include?(params[:sort_field]) && valid_orders.include?(params[:sort_order])
      case params[:sort_field]
      when "name"
        @sort_mode = "name_#{params[:sort_order]}"
        items.sort_by_name(params[:sort_order])
      else
        #items.order(params[:sort_field] => params[:sort_order])
        default_order(items)
      end
    else
      default_order(items)
    end
  end

  def default_order(items)
    @sort_mode = "name_asc"
    items.sort_by_name(:asc)
  end
end
