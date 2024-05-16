# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'

# Read the JSON file
file_path = Rails.root.join('db', 'models.json')
data = JSON.parse(File.read(file_path))

# Group models by brand to efficiently handle them
grouped_data = data.group_by { |item| item['brand_name'] }

grouped_data.each do |brand_name, models|
  # Create or find the brand
  brand = Brand.find_or_create_by!(name: brand_name)

  # Create models under each brand
  models.each do |model_data|
    brand.models.find_or_create_by!(
      name: model_data['name'],
      average_price: model_data['average_price']
    )
  end

  # Update the average price for the brand
  brand.update(average_price: brand.models.average(:average_price).to_f)
end

puts "Seeded #{Brand.count} brands and #{Model.count} models."
