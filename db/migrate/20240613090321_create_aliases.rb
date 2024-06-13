class CreateAliases < ActiveRecord::Migration[7.1]
  def change
    create_table :aliases do |t|
      t.belongs_to :artist, null: false, foreign_key: true
      t.belongs_to :related_artist, null: false, foreign_key: { to_table: :artists }

      t.timestamps
    end
  end
end
