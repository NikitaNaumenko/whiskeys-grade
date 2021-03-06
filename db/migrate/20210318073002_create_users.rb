# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email,  index: { unique: true }
      t.string :password_digest
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
