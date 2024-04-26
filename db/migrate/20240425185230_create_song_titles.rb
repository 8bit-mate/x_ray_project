class CreateSongTitles < ActiveRecord::Migration[7.1]
  def change
    create_table :song_titles do |t|

      t.timestamps
    end
  end
end
