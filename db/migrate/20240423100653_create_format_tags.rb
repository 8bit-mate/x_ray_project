class CreateFormatTags < ActiveRecord::Migration[7.1]
  def change
    create_table :format_tags do |t|
      t.timestamps
      t.boolean :visible, default: false
    end
  end
end
