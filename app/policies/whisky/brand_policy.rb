# frozen_string_literal: true

class Whisky::BrandPolicy < ApplicationPolicy
  def create?
    user.role_admin?
  end

  def new?
    user.role_admin?
  end

  def edit?
    user.role_admin?
  end

  def update?
    user.role_admin?
  end

  def destroy?
    user.role_admin?
  end
end
