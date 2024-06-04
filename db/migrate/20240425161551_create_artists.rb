class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.timestamps
      t.integer :songs_count, default: 0
    end
  end
end
