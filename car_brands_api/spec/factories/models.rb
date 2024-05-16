FactoryBot.define do
  factory :model do
    sequence(:name) { |n| "Model #{n}" }  # Ensures unique names by default
    average_price { 500000 }  # Default average price
    association :brand  # Ensures a brand is associated if none is provided
  end
end
