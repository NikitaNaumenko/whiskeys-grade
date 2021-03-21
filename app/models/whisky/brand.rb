# frozen_string_literal: true

class Whisky::Brand < ApplicationRecord
  has_many :whiskies, class_name: 'Whisky', dependent: :destroy
  validates :name, uniqueness: { case_sensitive: true },
                   presence: true, length: { minimum: 5, maximum: 255 }
  validates :country, presence: true
  validates :description, length: { maximum: 1024 }

  def country_name
    ISO3166::Country[country_code].name
  end

  def to_s
    name
  end
end
