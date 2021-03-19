# frozen_string_literal: true

class CreateWhiskyReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :whisky_reviews do |t|
      t.belongs_to :user
      t.belongs_to :whisky
      t.string :aasm_state
      t.text :body
      t.integer :taste
      t.integer :smokiness
      t.integer :color

      t.timestamps
    end
  end
end
