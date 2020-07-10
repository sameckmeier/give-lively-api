# frozen_string_literal: true

class Payment < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :non_profit

  validates :amount, presence: true, numericality: { greater_than: 0.00 }

  def send_payment
    # TODOD: Implement deposit functionality to allow GiveLively to transfer funds from payments account to non-member non profit
  end
end
