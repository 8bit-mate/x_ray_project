class Category < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  has_many :records, dependent: :nullify
  after_destroy :handle_records_after_destroy

  def frequency
    records.length
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
