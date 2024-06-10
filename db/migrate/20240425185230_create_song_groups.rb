class CreateSongGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :song_groups do |t|
      t.timestamps
    end
  end
end
