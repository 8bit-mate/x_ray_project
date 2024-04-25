# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Category.find_or_create_by!(
  id: 1,
  name_en: "Uncategorized",
  name_ru: "Несортированное",
  short_description_en: "Uncategorized",
  short_description_ru: "Несортированное",
  description_en: "",
  description_ru: "",
  visible: false
)

user = User.new
user.email = "admin@admin.su"
user.password = "admin@admin.su"
user.password_confirmation = "admin@admin.su"
user.role = "admin"
user.save!
