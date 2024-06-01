class RecordsController < ApplicationController
  before_action :set_record, only: %i[show]

  # GET /records or /records.json
  def index
    puts "==================================================================================================="
    puts params
    puts "==================================================================================================="

    # respond_to do |format|
    #   format.html { render :index }
    #   format.turbo_stream { render :index }
    # end

    @pagy, @records = pagy(
      sort_records(fetch_records),
      records: Rails.application.config.pagy_n_items
    )
  end

  # GET /records/1 or /records/1.json
  def show; end

  def random
    redirect_to record_url(Record.all.sample)
  end

  private

  def sort_records(records)
    if params[:sort_field] && params[:sort_order]
      sort_by_params(records)
    else
      default_order(records)
    end
  end

  def sort_by_params(records)
    # Validate field and order to prevent SQL injection
    valid_fields = Record.column_names  # Get allowed field names from model
    valid_orders = %w[asc desc]         # Allow only these order values

    if valid_fields.include?(params[:sort_field]) && valid_orders.include?(params[:sort_order])
      records.order(params[:sort_field] => params[:sort_order])
    else
      default_order(records)
    end
  end

  def default_order(records)
    records.order(created_at: :desc)
  end

  def fetch_records
    if params[:category_id].present?
      category = Category.friendly.find(params[:category_id])
      category.records
    else
      Record.all
    end
  end

  def sort_params
    params.fetch(:sort, {}).permit(
      :field,
      :order
    )
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = Record.find(params[:id])
  end
end
