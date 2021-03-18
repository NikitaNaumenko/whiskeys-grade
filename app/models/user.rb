# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true

  def guest?
    false
  end
end
