class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.timestamps
      t.boolean :visible, default: false
    end
  end
end
