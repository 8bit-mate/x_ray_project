class CreateRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :records do |t|
      t.integer :number, default: 0, null: false
      t.text :tech_info, default: "", null: false
      t.belongs_to :category, index: true, foreign_key: true
      t.belongs_to :label, index: true, foreign_key: true

      t.timestamps
    end
  end
end
