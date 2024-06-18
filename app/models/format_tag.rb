class FormatTag < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  has_many :format_tag_records, dependent: :destroy
  has_many :records, through: :format_tag_records

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
end
