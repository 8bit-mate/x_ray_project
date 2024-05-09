module TagWithImageController
  extend ActiveSupport::Concern

  private

  def tag_params(tag_name)
    params.require(tag_name).permit(
      :name_en,
      :name_ru,
      :short_description_en,
      :short_description_ru,
      :description_en,
      :description_ru,
      :visible,
      :image
    )
  end
end
