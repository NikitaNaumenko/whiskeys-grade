# frozen_string_literal: true

FactoryBot.define do
  factory :whisky_review, class: 'Whisky::Review' do
    summary { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    color { Whisky::Review.colors.keys.sample }
    taste { Whisky::Review.tastes.keys.sample }
    smokiness { 0 }
    whisky
    user
  end
end
