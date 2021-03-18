# frozen_string_literal: true

class Whisky::Brand < ApplicationRecord
  has_many :whiskies, class_name: 'Whisky', dependent: :destroy
  validates :name, uniqueness: { case_sensitive: true },
                   presence: true, length: { minimum: 5, maximum: 255 }
end
