class CreateLabelNameAndShortDescriptionAndDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :labels, :name_en, :string
    add_index  :labels, :name_en, name: :index_labels_on_name_en
    add_column :labels, :name_ru, :string
    add_index  :labels, :name_ru, name: :index_labels_on_name_ru
    add_column :labels, :short_description_en, :string
    add_index  :labels, :short_description_en, name: :index_labels_on_short_description_en
    add_column :labels, :short_description_ru, :string
    add_index  :labels, :short_description_ru, name: :index_labels_on_short_description_ru
    add_column :labels, :description_en, :text
    add_index  :labels, :description_en, name: :index_labels_on_description_en
    add_column :labels, :description_ru, :text
    add_index  :labels, :description_ru, name: :index_labels_on_description_ru
  end
end
