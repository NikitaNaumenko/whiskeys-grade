# frozen_string_literal: true

class Api::Whiskies::ReviewsController < Api::Whiskies::ApplicationController
  before_action :api_authenticate_user!

  def create
    review = resource_whisky.reviews.new(permitted_params)
    review.user = current_user

    if review.publish!
      render json: Whisky::ReviewSerializer.new(review, include: %i[user]).serializable_hash
    else
      render json: review.errors, status: :unprocessable_entity
    end
  end

  def permitted_params
    params.require(:review).permit(:body, :taste, :color, :summary, :smokiness)
  end
end
