Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes for brands with limited actions
  resources :brands, only: [:index, :create] do
    # Nested resource for creating a model within a specific brand
    # This generates routes like brands/:brand_id/models
    resources :models, only: [:create]
  end

  # Custom route to fetch models for a specific brand
  # Changed the name to avoid conflict
  get '/brands/:id/models', to: 'brands#models', as: 'list_brand_models'

  # Routes for models with limited actions
  resources :models, only: [:index, :update]
end
