class CreateFormatTagRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :format_tag_records do |t|
      t.belongs_to :format_tag, null: false, foreign_key: true
      t.belongs_to :record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
