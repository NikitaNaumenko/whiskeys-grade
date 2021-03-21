# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Whiskies', type: :request do
  describe 'GET /whiskies' do
    let(:brand) { create(:whisky_brand) }
    let(:brand2) { create(:whisky_brand) }

    let!(:whisky) { create(:whisky, brand: brand, title: '12 years old') }
    let!(:whisky2) { create(:whisky, brand: brand2) }
    let!(:whisky3) { create(:whisky, brand: brand, description: 'Amazing whisky') }

    it 'render whiskies' do
      get whiskies_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end

    context 'with ransack' do
      it 'returns by title' do
        query = { title_cont: 'years' }
        get whiskies_path(q: query)

        whiskies = assigns(:whiskies)

        expect(whiskies).to include(whisky)
        expect(whiskies).not_to include(whisky2)
        expect(whiskies).not_to include(whisky3)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end

      it 'returns by description' do
        query = { description_cont: 'whisky' }
        get whiskies_path(q: query)

        whiskies = assigns(:whiskies)

        expect(whiskies).to include(whisky3)
        expect(whiskies).not_to include(whisky)
        expect(whiskies).not_to include(whisky2)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end

      it 'returns by brand_id' do
        query = { brand_id_eq: brand2.id }
        get whiskies_path(q: query)

        whiskies = assigns(:whiskies)

        expect(whiskies).to include(whisky2)
        expect(whiskies).not_to include(whisky)
        expect(whiskies).not_to include(whisky3)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
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

      it 'creates whisky' do
        post whiskies_path, params: { whisky: whisky_params }

        whisky = Whisky.find_by(title: whisky_params[:title])

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(whisky_path(whisky))
      end
    end
  end

  describe 'PATCH /whiskies' do
    let(:brand) { create(:whisky_brand) }
    let(:whisky) { create(:whisky, brand: brand) }
    let(:whisky_params) { attributes_for(:whisky) }

    context 'when not logged' do
      it 'redirect to session' do
        patch whisky_path(whisky), params: { whisky: whisky_params }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { patch whisky_path(whisky), params: { whisky: whisky_params } }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'updates whisky' do
        patch whisky_path(whisky), params: { whisky: whisky_params }

        whisky = Whisky.find_by(title: whisky_params[:title])
        whisky.reload

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(whisky_path(whisky))
        expect(whisky.title).to eq(whisky_params[:title])
      end
    end
  end

  describe 'GET /whiskies/:id/edit' do
    let(:brand) { create(:whisky_brand) }
    let(:whisky) { create(:whisky, brand: brand) }
    let(:user) { create(:user) }

    context 'when not logged' do
      it 'redirect to session' do
        get edit_whisky_path(whisky)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { get edit_whisky_path(whisky) }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'render edit' do
        get edit_whisky_path(whisky)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /whiskies/:id' do
    let(:brand) { create(:whisky_brand) }
    let(:whisky) { create(:whisky, brand: brand) }
    let(:user) { create(:user) }

    context 'when not logged' do
      it 'redirect to session' do
        delete whisky_path(whisky)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { delete whisky_path(whisky) }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'destroy whisky' do
        delete whisky_path(whisky)

        expect(response).to have_http_status(:found)
        expect { whisky.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
