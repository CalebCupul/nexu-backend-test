require 'rails_helper'

RSpec.describe "Models", type: :request do
  describe "POST /brands/:brand_id/models" do
    it "creates a new model for a specific brand" do
      brand = create(:brand, name: "Acura")
      model_params = { model: { name: "Prius", average_price: 406400 } }
      
    
      post brand_models_path(brand), params: model_params
      expect(response).to have_http_status(201)
      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq("Prius")
      expect(json_response["average_price"]).to eq(406400)
      expect(json_response["brand_id"]).to eq(brand.id)
    end

    it "returns an error if the model name already exists for the brand" do
      brand = create(:brand)
      create(:model, name: "Prius", brand: brand)
      model_params = { model: { name: "Prius", average_price: 406400 } }

      post brand_models_path(brand), params: model_params
      expect(response).to have_http_status(422)
      json_response = JSON.parse(response.body)
      expect(json_response["errors"]).to include("Name Model name must be unique within a brand")
    end

    it "returns an error if the brand does not exist" do
      model_params = { model: { name: "Prius", average_price: 406400 } }

      post "/brands/999/models", params: model_params

      expect(response).to have_http_status(404)
    end

    it "returns an error if the average price is less than 100000" do
      brand = create(:brand)
      model_params = { model: { name: "Prius", average_price: 50000 } }

      post brand_models_path(brand), params: model_params

      expect(response).to have_http_status(422)
      json_response = JSON.parse(response.body)
      expect(json_response["errors"]).to include("Average price must be greater than 100000")
    end
  end

  describe "PUT /models/:id" do
    it "updates the average price of a model" do
      model = create(:model)
      update_params = { model: { average_price: 406400 } }

      put model_path(model), params: update_params

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response["average_price"]).to eq(406400)
    end

    it "returns an error if the average price is less than 100000" do
      model = create(:model)
      update_params = { model: { average_price: 50000 } }

      put model_path(model), params: update_params

      expect(response).to have_http_status(422)
      json_response = JSON.parse(response.body)
      expect(json_response["average_price"]).to include("must be greater than 100000")
    end
  end

  describe "GET /models" do
    it "returns a list of models" do
      brand1 = create(:brand)
 
      1...3.times do
        create(:model, brand: brand1)
      end
    
      get models_path
    
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(3)
    end
    
    it "returns a list of models with average_price greater than a given value" do
      brand1 = create(:brand)

      create(:model, average_price: 400000 , brand: brand1)
      create(:model, average_price: 500000 , brand: brand1)

      get models_path, params: { greater: 450000 }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(1)
    end

    it "returns a list of models with average_price lower than a given value" do
      brand1 = create(:brand)

      create(:model, average_price: 400000 , brand: brand1)
      create(:model, average_price: 500000 , brand: brand1)

      get models_path, params: { lower: 450000 }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(1)
    end
  end
end
