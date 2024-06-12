class CreateFormatTags < ActiveRecord::Migration[7.1]
  def change
    create_table :format_tags do |t|
      t.boolean :visible, default: false
      t.integer :records_count, default: 0

      t.timestamps
    end
  end
end
