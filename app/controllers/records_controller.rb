class RecordsController < ApplicationController
  before_action :set_record, only: %i[show]

  # GET /records or /records.json
  def index
    @q = filter_records.ransack(params[:q])
    @q.sorts = "number" if @q.sorts.blank?
    @pagy, @records = pagy(@q.result, anchor_string: 'data-turbo-stream="true"')
  end

  # GET /records/1 or /records/1.json
  def show; end

  def random
    redirect_to record_url(Record.find(Record.pluck(:id).sample))
  end

  private

  def filter_records
    if params[:category_id].present?
      category = Category.friendly.find(params[:category_id])
      category.records
    elsif params[:label_id].present?
      # label = Label.friendly.find(params[:label_id])
      label = Label.visible.friendly.includes(sub_labels: { sub_labels: :records }).find(params[:label_id])
      label.all_records
    elsif params[:artist_id].present?
      artist = Artist.friendly.find(params[:artist_id])
      artist.records
    elsif params[:song_id].present?
      song = Song.friendly.find(params[:song_id])
      song.records
    elsif params[:format_tag_id].present?
      format_tag = FormatTag.friendly.find(params[:format_tag_id])
      format_tag.records
    else
      Record.all
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = Record.friendly.find(params[:id])
  end
end
