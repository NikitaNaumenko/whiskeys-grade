# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: { case_sensitive: true }

  def guest?
    false
  end

  def valid_password?(password)
    return false if password_digest.nil?

    authenticate(password)
  end
end
