# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users/new' do
    it 'render new' do
      get new_user_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /users' do
    let(:email) { Faker::Internet.email }
    let(:password) { SecureRandom.hex }

    it 'creates user' do
      post users_path, params: { user: { email: email, password: password } }
      expect(response).to have_http_status(:found)

      user = User.find_by(email: email)
      expect(user).to be_persisted
    end
  end
end
