# frozen_string_literal: true

class CreateWhiskyBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :whisky_brands do |t|
      t.string :name, index: { unique: true }
      t.string :country

      t.timestamps
    end
  end
end
