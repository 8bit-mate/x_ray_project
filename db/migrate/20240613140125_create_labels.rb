class CreateLabels < ActiveRecord::Migration[7.1]
  def change
    create_table :labels do |t|
      t.references :parent_label, foreign_key: { to_table: :labels }
      t.boolean :visible, default: false
      t.integer :records_count, default: 0

      t.timestamps
    end
  end
end
