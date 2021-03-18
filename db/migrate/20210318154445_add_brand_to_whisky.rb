# frozen_string_literal: true

class AddBrandToWhisky < ActiveRecord::Migration[6.1]
  def change
    add_reference :whiskies, :brand
  end
end
