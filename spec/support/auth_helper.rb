# frozen_string_literal: true

module AuthHelper
  def login(user, password: 'password')
    post session_path, params: { user_sign_in_form: { email: user.email, password: password } }
  end
end
