class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.integer :year_released

      t.timestamps
    end
  end
end
