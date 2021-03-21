# frozen_string_literal: true

class Whisky::BrandSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :country, :description

  has_many :whiskies
end
