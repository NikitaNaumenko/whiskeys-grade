# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /sessions/new' do
    it 'render new' do
      get new_session_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /users' do
    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:password) { 'password' }

    it 'creates user' do
      post sessions_path, params: { user_sign_in_form: { email: email, password: password } }
      expect(response).to have_http_status(:ok)
    end
  end
end
