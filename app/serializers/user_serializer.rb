# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email
  attribute :is_guest, &:guest?
  attribute :is_admin, &:role_admin?
end
