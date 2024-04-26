class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.integer :year_of_release
      t.string :full_title
      t.belongs_to :song_title, index: true, foreign_key: true

      t.timestamps
    end
  end
end
