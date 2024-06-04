class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.timestamps
      t.boolean :visible, default: false
      t.integer :records_count, default: 0
    end
  end
end
