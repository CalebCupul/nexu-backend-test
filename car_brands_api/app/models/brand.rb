class Brand < ApplicationRecord
  has_many :models, dependent: :destroy

  # Validates that the name is present and unique
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def as_json(options={})
    super(options.merge({ except: [:created_at, :updated_at] }))
  end

end
