# frozen_string_literal: true

class GuestSerializer
  include JSONAPI::Serializer

  attribute :id
  attribute :is_guest, &:guest?
  attribute :is_admin, &:role_admin?
end
