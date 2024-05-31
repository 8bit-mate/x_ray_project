class RecordsController < ApplicationController
  before_action :set_record, only: %i[show]

  # GET /records or /records.json
  def index
    @pagy, @records = pagy(
      Record.all,
      items: Rails.application.config.pagy_n_items
    )
  end

  # GET /records/1 or /records/1.json
  def show; end

  def random
    redirect_to record_url(Record.all.sample)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = Record.find(params[:id])
  end
end
