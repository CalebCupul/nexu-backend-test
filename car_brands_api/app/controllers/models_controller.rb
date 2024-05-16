class ModelsController < ApplicationController
  before_action :set_model, only: [:update]

  def index
    @models = Model.all

    # Filter models with average_price greater than the 'greater' param
    if params[:greater].present?
      @models = @models.where('average_price > ?', params[:greater].to_i)
    end

    # Filter models with average_price lower than the 'lower' param
    if params[:lower].present?
      @models = @models.where('average_price < ?', params[:lower].to_i)
    end

    render json: @models
  end


  # POST /models
  def create
    brand = Brand.find(params[:brand_id])
    model = brand.models.new(model_params)

    if model.save
      render json: model, status: :created
    else
      render json: { errors: model.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /models/:id
  def update
    if @model.update(model_params)
      render json: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  private

  def set_model
    @model = Model.find(params[:id])
    Rails.logger.debug(@model)
  end

  # Only allow a list of trusted parameters through.
  def model_params
    params.require(:model).permit(:name, :average_price, :brand_id)
  end
end
