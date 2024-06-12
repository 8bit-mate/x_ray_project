class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.integer :songs_count, default: 0
      t.integer :records_count, default: 0

      t.timestamps
    end
  end
end
