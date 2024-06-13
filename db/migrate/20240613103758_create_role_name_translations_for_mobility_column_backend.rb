class CreateRoleNameTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :roles, :name_en, :string
    add_index  :roles, :name_en, name: :index_roles_on_name_en
    add_column :roles, :name_ru, :string
    add_index  :roles, :name_ru, name: :index_roles_on_name_ru
  end
end
