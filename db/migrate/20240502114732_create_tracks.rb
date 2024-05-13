class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :number
      t.belongs_to :song, index: true, foreign_key: true
      t.belongs_to :record, index: true, foreign_key: true

      t.timestamps
    end
  end
end
