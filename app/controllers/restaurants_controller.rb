class RestaurantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    # restaurants = Restaurant.all
    render json: Restaurant.all
  end

  def show
    # restaurant = Restaurant.find_by(params[:id])
    restaurant = find_restaurant
    render json: restaurant, serializer: RestaurantPizzasSerializer
  end

  def destroy
    # restaurant = Restaurant.find_by(params[:id])
    restaurant = find_restaurant
    restaurant.destroy
    head :no_content
  end

  private

  def find_restaurant
    Restaurant.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Restaurant not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    renser json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
  end
end
