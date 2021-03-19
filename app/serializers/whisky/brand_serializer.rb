# frozen_string_literal: true

class Whisky::BrandSerializer
  include JSONAPI::Serializer

  attributes :name, :country, :description

  has_many :whiskies
end
