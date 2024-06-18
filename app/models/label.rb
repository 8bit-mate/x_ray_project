class Label < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  has_many :sub_labels,
           class_name: "Label",
           foreign_key: "parent_label_id",
           dependent: :nullify,
           inverse_of: :parent_label
  belongs_to :parent_label, class_name: "Label", optional: true

  has_one_attached :image, dependent: :purge_later do |image|
    image.variant :preview, resize_to_limit: [300, 300]
  end

  has_many :records, dependent: :nullify
  after_destroy :handle_records_after_destroy

  def self.ransackable_associations(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[records]
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[name records_count]
    end
  end

  def parent? = sub_labels.count.positive?

  def sub? = parent_label ? true : false

  def lonely? = parent? || sub? ? false : true

  private

  #
  # Set default label for all records doesn't have a label after
  # the current label has been destroyed.
  #
  def handle_records_after_destroy
    label = Label.find_or_create_by(name_en: "Unknown Label")

    Record.without_label.each do |record|
      record.label = label
      record.save
    end
  end
end
