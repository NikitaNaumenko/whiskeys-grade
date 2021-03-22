# frozen_string_literal: true

class CreateWhiskies < ActiveRecord::Migration[6.1]
  def change
    create_table :whiskies do |t|
      t.string :title, index: { unique: true }
      t.text :description
      t.integer :reviews_count, default: 0

      t.timestamps
    end
  end
end
