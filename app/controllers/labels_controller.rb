class LabelsController < ApplicationController
  # GET /labels or /labels.json
  def index
    @labels = Label.all.with_records
  end

  # GET /labels/1 or /labels/1.json
  def show
    @label = Label.all.friendly.find(params[:id])
  end
end
