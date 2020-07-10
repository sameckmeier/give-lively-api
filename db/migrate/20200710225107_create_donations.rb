# frozen_string_literal: true

class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.decimal :amount, precision: 7, scale: 2, default: 0.0.to_d, null: false
      t.boolean :fulfilled, default: false
      
      t.references :non_profit, foreign_key: true
      t.references :payment, type: :uuid

      t.timestamps
    end
  end
end
