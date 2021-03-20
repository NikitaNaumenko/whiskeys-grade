# frozen_string_literal: true

class Whisky::Review < ApplicationRecord
  include AASM

  COLORS_TO_HEX = {
    white_wine: '#FDFDE5',
    pale_straw: '#FDF098',
    pale_gold: '#F6EB81',
    jonquiripe_corn: '#F9E266',
    yellow_gold: '#F8DF55',
    old_gold: '#F4DD4C',
    amber: '#FACF47',
    deep_gold: '#F7C94C',
    amontillado_sherry: '#F1C42E',
    deep_copper: '#F3BE2D',
    burnished: '#EBAF1D',
    chestnut_oloroso_sherry: '#EDA122',
    russet_muscat: '#DC9A27',
    tawny: '#DE7329',
    auburn: '#E26828',
    mahogany: '#D24F31',
    burnt_umber: '#B02E29',
    old_oak: '#A32022',
    brown_sherry: '#712C1D',
    treacle: '#411B0C'
  }.with_indifferent_access.freeze

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
    white_wine: 0,
    pale_straw: 1,
    pale_gold: 2,
    jonquiripe_corn: 3,
    yellow_gold: 4,
    old_gold: 5,
    amber: 6,
    deep_gold: 7,
    amontillado_sherry: 8,
    deep_copper: 9,
    burnished: 10,
    chestnut_oloroso_sherry: 11,
    russet_muscat: 12,
    tawny: 13,
    auburn: 14,
    mahogany: 15,
    burnt_umber: 16,
    old_oak: 17,
    brown_sherry: 18,
    treacle: 19
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
