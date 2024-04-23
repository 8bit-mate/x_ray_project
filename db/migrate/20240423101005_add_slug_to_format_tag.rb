class AddSlugToFormatTag < ActiveRecord::Migration[7.1]
  def change
    add_column :format_tags, :slug, :string
    add_index :format_tags, :slug, unique: true
  end
end
