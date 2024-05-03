class CreateRecordTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :record_tracks do |t|
      t.belongs_to :record, null: false, foreign_key: true
      t.belongs_to :track, null: false, foreign_key: true

      t.timestamps
    end
  end
end
