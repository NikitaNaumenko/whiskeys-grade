# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /session/new' do
    it 'render new' do
      get new_session_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /session' do
    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:password) { 'password' }

    it 'logged in' do
      post session_path, params: { user_sign_in_form: { email: email, password: password } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE /session' do
    let(:user) { create(:user) }
    let(:email) { user.email }

    before do
      login(user)
    end

    it 'logged out' do
      delete session_path
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
    end
  end
end
