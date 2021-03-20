# frozen_string_literal: true

class Api::Whiskies::ReviewsController < Api::Whiskies::ApplicationController
  def create
    review = resource_whisky.reviews.new(permitted_params)
    review.user = current_user
    review.save

    if review.save
      render json: Whisky::ReviewSerializer.new(review).serialized_json
    else
      render json: review.errors, status: :unprocessable_entity
    end
  end

  def permitted_params
    params.require(:review).permit(:body, :taste, :color, :summary, :smokiness)
  end
end
