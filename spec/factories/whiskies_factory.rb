# frozen_string_literal: true

FactoryBot.define do
  factory :whisky do
    title { Faker::Beer.name }
    description { Faker::Games::Dota.quote }

    brand factory: :whisky_brand
  end
end
