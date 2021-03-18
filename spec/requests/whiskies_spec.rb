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
      before { login(user) }

      it 'render whisky' do
        get whisky_path(whisky)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end

    context 'when user did`t logged' do
      it 'redirect to session' do
        get whisky_path(whisky)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'GET /whiskies/new' do
    context 'when not logged' do
      it 'redirect to session' do
        get new_whisky_path

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { get new_whisky_path }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'render new' do
        get new_whisky_path

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST /whiskies' do
    let(:brand) { create(:whisky_brand) }
    let(:whisky_params) { attributes_for(:whisky, brand_id: brand.id) }

    context 'when not logged' do
      it 'redirect to session' do
        post whiskies_path, params: { whisky: whisky_params }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { post whiskies_path, params: { whisky: whisky_params } }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'raises 403' do
        post whiskies_path, params: { whisky: whisky_params }

        whisky = Whisky.find_by(title: whisky_params[:title])

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(whisky_path(whisky))
      end
    end
  end
end
