# frozen_string_literal: true

class NonProfit < ApplicationRecord
  has_many :payments
  has_many :donations

  validates :name, presence: true

  scope :requires_payment, -> { where(member: false).where('unpaid_donation_amount > ?', 0.0.to_d) }

  def subtract_payment(amount)
    update!(unpaid_donation_amount: unpaid_donation_amount - amount.to_d)
  rescue StandardError => e
    logger.error("Failed to subtract donation amount #{amount.to_d} from Non Profit - ID #{id} - #{e.message}")
  end
end
