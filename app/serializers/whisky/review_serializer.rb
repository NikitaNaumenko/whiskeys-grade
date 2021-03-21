# frozen_string_literal: true

class Whisky::ReviewSerializer
  include JSONAPI::Serializer

  attributes :id, :summary, :body, :smokiness, :taste, :color, :aasm_state
  belongs_to :user, serializer: UserSerializer
  belongs_to :whisky, serializer: WhiskySerializer
end
