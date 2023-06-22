class PlantsController < ApplicationController
    before_action :set_plant, only: [:show]

  def index
    @plants = Plant.all
    render json: @plants
  end

  def show
    render json: @plant
  end

  def create
    @plant = Plant.new(plant_params)

    if @plant.save
      render json: @plant, status: :created
    else
      render json: { errors: @plant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Plant not found" }, status: :not_found
  end

  def plant_params
    params.require(:plant).permit(:name, :image, :price)
  end
end