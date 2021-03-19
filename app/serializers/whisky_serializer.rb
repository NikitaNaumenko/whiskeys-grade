# frozen_string_literal: true

class WhiskySerializer
  include JSONAPI::Serializer

  attributes :id, :title, :description, :full_name
  has_many :reviews, serializer: Whisky::ReviewSerializer
  belongs_to :brand, serializer: Whisky::BrandSerializer
end
