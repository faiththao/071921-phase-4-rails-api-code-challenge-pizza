class RestaurantPizzasController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create 
    restaurant_pizza = RestaurantPizza.create!(rp_params)
    render json: restaurant_pizza.pizza, status: :created
  end

  private

  def rp_params
    params.permit(:pizza_id, :restaurant_id, :price)
  end

  def render_unprocessable_entity_response(exception)
    render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
  end
end
