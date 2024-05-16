class Model < ApplicationRecord
  belongs_to :brand

  # Validates that the model's name is unique within the scope of a single brand
  validates :name, uniqueness: { scope: :brand_id, message: "Model name must be unique within a brand" }

  # Validates that average_price, if provided, is greater than 100,000
  validates :average_price, numericality: { greater_than: 100000 }, allow_blank: true

  after_save :update_brand_average_price

  def as_json(options={})
    super(options.merge({ except: [:created_at, :updated_at] }))
  end

  private

  def update_brand_average_price
    brand.update(average_price: brand.models.average(:average_price).to_f)
  end

  
end