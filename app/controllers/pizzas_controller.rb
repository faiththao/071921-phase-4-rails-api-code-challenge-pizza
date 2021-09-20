class PizzasController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index 
    # pizzas = Pizza.all
    render json: Pizza.all
  end

  private 

  def render_not_found_response
    render json: {error: "Pizza not found"}, status: :not_found
  end
end
