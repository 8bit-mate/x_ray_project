class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.integer :year_of_release
      t.string :full_title
      t.belongs_to :song_group, index: true, foreign_key: true
      t.belongs_to :main_artist, foreign_key: { to_table: "artists" }
      t.integer :records_count, default: 0

      t.timestamps
    end
  end
end
