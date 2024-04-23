class Record < ApplicationRecord
  belongs_to :category

  has_many :format_tag_records, dependent: :destroy
  has_many :format_tags, through: :format_tag_records

  def create_or_update_tags(tags_params)
    create_or_update_category(tags_params[:category_id])
  end

  private

  def create_or_update_category(category_id)
    return if category_id.nil?

    self.category = Category.find_by(id: category_id)
  end
end
