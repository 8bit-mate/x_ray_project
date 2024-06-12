class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.boolean :visible, default: false
      t.integer :records_count, default: 0

      t.timestamps
    end
  end
end
