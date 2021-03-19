# frozen_string_literal: true

class Whisky::Review < ApplicationRecord
  include AASM

  belongs_to :whisky
  belongs_to :user

  enum taste: {
    woody: 0,
    winey: 1,
    cereal: 2,
    fruity: 3,
    floral: 4,
    peaty: 5,
    fenity: 6,
    sulphural: 7
  }

  enum color: {
    gin_clear: 0,
    white_wine: 1,
    pale_straw: 2,
    pale_gold: 3,
    jonquiripe_corn: 4,
    yellow_gold: 5,
    old_gold: 6,
    amber: 7,
    deep_gold: 8,
    amontillado_sherry: 9,
    deep_copper: 10,
    burnished: 11,
    chestnut_oloroso_sherry: 12,
    russet_muscat: 13,
    tawny: 14,
    auburn: 15,
    mahogany: 16,
    burnt_umber: 17,
    old_oak: 18,
    brown_sherry: 19,
    treacle: 20
  }

  validates :summary, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 1024 }
  validates :smokiness, presence: true, numericality: { only_integer: true,
                                                        greater_than_or_equal_to: 0,
                                                        less_than_or_equal_to: 5 }

  aasm do
    state :draft, initial: true
    state :published, :archived

    event :publish do
      transitions from: :draft, to: :published
    end

    event :archive do
      transitions to: :archived
    end
  end
end
