class CreateRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :records do |t|
      t.text :tech_info

      t.timestamps
    end
  end
end
