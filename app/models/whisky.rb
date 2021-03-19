# frozen_string_literal: true

class Whisky < ApplicationRecord
  belongs_to :brand
  has_many :reviews, dependent: :destroy

  validates :title, uniqueness: { case_sensitive: true },
                    presence: true, length: { minimum: 5, maximum: 255 }
  validates :description, presence: true, length: { maximum: 1024 }

  def full_name
    [brand.name, title].join(' ')
  end

  def to_s
    full_name
  end
end
