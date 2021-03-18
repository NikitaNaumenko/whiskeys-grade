# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Whiskies', type: :request do
  describe 'GET /whiskies' do
    it 'render whiskies' do
      get whiskies_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /whiskies/:id' do
    let(:brand) { create(:whisky_brand) }
    let(:whisky) { create(:whisky, brand: brand) }
    let(:user) { create(:user) }

    context 'when user logged' do
      before do
        login(user)
      end

      it 'render whisky' do
        get whisky_path(whisky)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end

    context 'when user did`t logged' do
      it 'redirect back' do
        get whisky_path(whisky)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
