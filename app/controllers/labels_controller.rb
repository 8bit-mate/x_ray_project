class LabelsController < ApplicationController
  # GET /labels or /labels.json
  def index
    @labels = Label.visible
                   .independent
                   .with_records
                   .includes(%i[sub_labels image_attachment])
  end

  # GET /labels/1 or /labels/1.json
  def show
    # @label = Label.visible.friendly.includes(sub_labels: { sub_labels: :records }).find(params[:id])
    @label = Label.visible.friendly.find(params[:id])
  end
end
