# frozen_string_literal: true

FactoryBot.define do
  factory :whisky_brand, class: 'Whisky::Brand' do
    name { Faker::FunnyName.two_word_name }
    country { Faker::Address.country }
  end
end
