class CreateFormatTagNameAndShortDescriptionAndDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :format_tags, :name_en, :string
    add_index  :format_tags, :name_en, name: :index_format_tags_on_name_en
    add_column :format_tags, :name_ru, :string
    add_index  :format_tags, :name_ru, name: :index_format_tags_on_name_ru
    add_column :format_tags, :short_description_en, :string
    add_index  :format_tags, :short_description_en, name: :index_format_tags_on_short_description_en
    add_column :format_tags, :short_description_ru, :string
    add_index  :format_tags, :short_description_ru, name: :index_format_tags_on_short_description_ru
    add_column :format_tags, :description_en, :text
    add_index  :format_tags, :description_en, name: :index_format_tags_on_description_en
    add_column :format_tags, :description_ru, :text
    add_index  :format_tags, :description_ru, name: :index_format_tags_on_description_ru
  end
end
