class Category < ApplicationRecord
  extend Mobility
  extend FriendlyId
  include Tag

  validates :image, presence: true

  has_one_attached :image, dependent: :purge_later do |image|
    image.variant :preview, resize_to_limit: [300, 300]
  end

  has_many :records, dependent: :nullify
  after_destroy :handle_records_after_destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[name name_en name_ru records_count]
  end

  private

  #
  # Set default category for all records doesn't have a category after
  # the current category has been destroyed.
  #
  def handle_records_after_destroy
    category = Category.find_or_create_by(name_en: "Uncategorized")

    Record.without_category.each do |record|
      record.category = category
      record.save
    end
  end
end
