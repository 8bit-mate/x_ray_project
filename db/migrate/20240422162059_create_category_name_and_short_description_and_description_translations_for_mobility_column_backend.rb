class CreateCategoryNameAndShortDescriptionAndDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :name_en, :string
    add_index  :categories, :name_en, name: :index_categories_on_name_en
    add_column :categories, :name_ru, :string
    add_index  :categories, :name_ru, name: :index_categories_on_name_ru
    add_column :categories, :short_description_en, :string
    add_index  :categories, :short_description_en, name: :index_categories_on_short_description_en
    add_column :categories, :short_description_ru, :string
    add_index  :categories, :short_description_ru, name: :index_categories_on_short_description_ru
    add_column :categories, :description_en, :text
    add_index  :categories, :description_en, name: :index_categories_on_description_en
    add_column :categories, :description_ru, :text
    add_index  :categories, :description_ru, name: :index_categories_on_description_ru
  end
end
