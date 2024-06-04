class RecordsController < ApplicationController
  before_action :set_record, only: %i[show]

  # GET /records or /records.json
  def index
    # @records = Record.all

    @q = Record.all.ransack(params[:q])
    @q.sorts = "number" if @q.sorts.blank?
    @pagy, @records = pagy(@q.result)
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
