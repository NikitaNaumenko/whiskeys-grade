# frozen_string_literal: true

class User < ApplicationRecord
  has_many :whisky_reviews, class_name: 'Whisky::Review', dependent: :destroy

  has_secure_password validations: false

  validates :email, presence: true
  enum role: { user: 0, admin: 1 }, _prefix: true

  def guest?
    false
  end

  def valid_password?(password)
    return false if password_digest.nil?

    authenticate(password)
  end

  def to_builder
    Jbuilder.new do |user|
      user.key_format! camelize: :lower

      user.id id
      user.email email
      user.is_guest guest?
      user.is_admin role_admin?
    end
  end
end
