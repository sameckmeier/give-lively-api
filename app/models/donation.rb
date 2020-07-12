# frozen_string_literal: true

class Donation < ApplicationRecord
  belongs_to :non_profit
  belongs_to :payment, optional: true

  validates :amount, presence: true, numericality: { greater_than: 0.0.to_d }

  after_create :add_amount_to_non_profit_donation_amount

  scope :requires_payment, -> { where(payment_id: nil) }

  private

  def add_amount_to_non_profit_donation_amount
    non_profit.update!(unpaid_donation_amount: non_profit.unpaid_donation_amount + amount)
  rescue StandardError => e
    logger.error("Failed to add Donation amount to NonProfit unpaid_donation_amount: #{e}")
    raise ActiveRecord::Rollback
  end
end
