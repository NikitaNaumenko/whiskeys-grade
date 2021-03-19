# frozen_string_literal: true

class Whisky::ReviewSerializer
  include JSONAPI::Serializer

  attributes :summary, :body, :smokiness, :taste, :color, :aasm_state
  belongs_to :user
  belongs_to :whisky
end
