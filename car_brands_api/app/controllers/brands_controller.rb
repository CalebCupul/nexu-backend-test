class BrandsController < ApplicationController
  before_action :set_brand, only: [:models]

  # GET /brands
  # List all brands
  def index
    @brands = Brand.all
    render json: @brands
  end

  # POST /brands
  # Create a new brand
  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      render json: @brand, status: :created
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  # GET /brands/:id/models
  # List all models for a specific brand
  def models
    render json: @brand.models
  end

  private

  # Use callbacks to share common setup or constraints between actions
  def set_brand
    @brand = Brand.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Brand not found" }, status: :not_found
  end

  # Only allow a trusted parameter "white list" through
  def brand_params
    params.require(:brand).permit(:name)
  end
end
