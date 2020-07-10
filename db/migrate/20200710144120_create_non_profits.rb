# frozen_string_literal: true

class CreateNonProfits < ActiveRecord::Migration[6.0]
  def change
    create_table :non_profits do |t|
      t.string :name, null: false
      t.string :address
      t.boolean :member, default: false
      t.decimal :unpaid_donation_amount, precision: 8, scale: 2, default: 0.0.to_d, null: false

      t.timestamps
    end
  end
end
