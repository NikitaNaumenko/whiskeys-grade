# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api Whisky Reviews', type: :request do
  describe 'POST /whiskies' do
    let(:whisky) { create(:whisky) }
    let(:review_params) { attributes_for(:whisky_review) }

    context 'when not logged' do
      it 'redirect to session' do
        post api_whisky_reviews_path(whisky), params: { review: review_params }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'creates whisky' do
        post api_whisky_reviews_path(whisky), params: { review: review_params }

        review = Whisky::Review.find(parsed_body['data']['id'])

        expect(response).to have_http_status(:ok)
        expect(review).to be_published
      end

      it 'gets errors' do
        post api_whisky_reviews_path(whisky), params: { review: review_params.except(:body, :smokiness) }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_body).to have_key('body')
        expect(parsed_body).to have_key('smokiness')
      end
    end
  end
end
