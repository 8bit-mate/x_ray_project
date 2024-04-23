module TagController
  extend ActiveSupport::Concern

  private

  def tag_params
    params.require(:category).permit(
      :name_en,
      :name_ru,
      :short_description_en,
      :short_description_ru,
      :description_en,
      :description_ru
    )
  end
end
