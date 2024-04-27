class CreateArtistSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :artist_songs do |t|
      t.belongs_to :artist, null: false, foreign_key: true
      t.belongs_to :song, null: false, foreign_key: true
      t.integer :order, default: 0, null: false

      t.timestamps
    end
  end
end
