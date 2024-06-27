class CreateArtistBands < ActiveRecord::Migration[7.1]
  def change
    create_table :artist_bands do |t|
      t.belongs_to :artist, foreign_key: true
      t.belongs_to :band, foreign_key: { to_table: :artists }

      t.timestamps
    end
  end
end
