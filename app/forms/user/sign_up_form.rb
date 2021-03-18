# frozen_string_literal: true

class User::SignUpForm < User
  include ActiveFormModel

  permit :email, :password

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :password, presence: true

  def email=(email)
    if email.present?
      write_attribute(:email, email.downcase)
    else
      super
    end
  end
end
