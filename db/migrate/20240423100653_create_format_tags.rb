class CreateFormatTags < ActiveRecord::Migration[7.1]
  def change
    create_table :format_tags do |t|

      t.timestamps
    end
  end
end
