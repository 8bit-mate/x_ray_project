class Label < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  # validates :image, presence: true

  has_many :sub_labels,
           class_name: "Label",
           foreign_key: "parent_label_id",
           dependent: :nullify,
           inverse_of: :parent_label
  belongs_to :parent_label,
             class_name: "Label",
             optional: true,
             touch: true

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

  # The label is a parent label for sub-labels?
  def parent? = sub_labels.count.positive?

  # The label has at lease one visible sub-label?
  def parent_of_visible? = sub_labels.visible.count.positive?

  # The label is a sub-label?
  def sub? = parent_label ? true : false

  # The label is "stand_alone" (i.e. doesn't have any relations with other labels)?
  def stand_alone? = !(parent? || sub?)

  # Find all records associated with this label and all its sub-labels.
  def all_records
    Record.where(label_id: all_label_ids)
  end

  def all_label_ids
    [id] + sub_labels.map(&:all_label_ids).flatten.uniq
  end

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
