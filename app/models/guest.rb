# frozen_string_literal: true

class Guest
  def id
    nil
  end

  def guest?
    true
  end

  def role_admin?
    false
  end

  def to_builder
    Jbuilder.new do |user|
      user.key_format! camelize: :lower

      user.id id
      user.is_guest guest?
      user.is_admin role_admin?
    end
  end
end
