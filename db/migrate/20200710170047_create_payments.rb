# frozen_string_literal: true

# For more info on UUIDs with postgres: https://guides.rubyonrails.org/active_record_postgresql.html#uuid-primary-keys

class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :payments, id: :uuid do |t|
      t.decimal :amount, precision: 8, scale: 2, default: 0.0.to_d, null: false
      t.boolean :fulfilled, default: false

      t.references :non_profit, foreign_key: true

      t.timestamps
    end
  end
end
