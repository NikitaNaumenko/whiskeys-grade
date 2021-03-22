# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Whisky Brands', type: :request do
  describe 'GET /whisky_brands' do
    it 'render whisky brands' do
      get whisky_brands_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /whiskies/:id' do
    let(:brand) { create(:whisky_brand) }
    let(:user) { create(:user) }

    context 'when user logged' do
      before { login(user) }

      it 'render whisky' do
        get whisky_brand_path(brand)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end

    context 'when user did`t logged' do
      it 'redirect to session' do
        get whisky_brand_path(brand)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET /whiskies/new' do
    context 'when not logged' do
      it 'redirect to session' do
        get new_whisky_brand_path

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { get new_whisky_brand_path }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'render new' do
        get new_whisky_brand_path

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST /whiskies' do
    let(:brand_params) { attributes_for(:whisky_brand) }

    context 'when not logged' do
      it 'redirect to session' do
        post whisky_brands_path, params: { whisky_brand: brand_params }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { post whisky_brands_path, params: { whisky_brand: brand_params } }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'creates whisky' do
        post whisky_brands_path, params: { whisky_brand: brand_params }

        brand = Whisky::Brand.find_by(name: brand_params[:name])

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(whisky_brand_path(brand))
      end
    end
  end

  describe 'PATCH /whiskies' do
    let(:brand) { create(:whisky_brand) }
    let(:brand_params) { attributes_for(:whisky_brand) }

    context 'when not logged' do
      it 'redirect to session' do
        patch whisky_brand_path(brand), params: { whisky_brand: brand_params }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { patch whisky_brand_path(brand), params: { whisky_brand: brand_params } }
          .to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'updates whisky brand' do
        patch whisky_brand_path(brand), params: { whisky_brand: brand_params }

        brand = Whisky::Brand.find_by(name: brand_params[:name])
        brand.reload

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(whisky_brand_path(brand))
        expect(brand.name).to eq(brand_params[:name])
      end
    end
  end

  describe 'GET /whiskies/:id/edit' do
    let(:brand) { create(:whisky_brand) }
    let(:user) { create(:user) }

    context 'when not logged' do
      it 'redirect to session' do
        get edit_whisky_brand_path(brand)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { get edit_whisky_brand_path(brand) }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'render edit' do
        get edit_whisky_brand_path(brand)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /whiskies/:id' do
    let(:brand) { create(:whisky_brand) }
    let(:user) { create(:user) }

    context 'when not logged' do
      it 'redirect to session' do
        delete whisky_brand_path(brand)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when not authorized' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'raises 403' do
        expect { delete whisky_brand_path(brand) }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, role: :admin) }

      before { login(user) }

      it 'destroy whisky' do
        delete whisky_brand_path(brand)

        expect(response).to have_http_status(:found)
        expect { brand.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
