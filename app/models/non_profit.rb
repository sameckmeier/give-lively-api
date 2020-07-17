# frozen_string_literal: true

class NonProfit < ApplicationRecord
  PAGINATES_PER = 5

  has_many :payments
  has_many :donations

  validates :name, presence: true

  paginates_per PAGINATES_PER
  scope :requires_payment, -> { where(member: false).where('unpaid_donation_amount > ?', 0.0.to_d) }

  def subtract_payment(payment)
    if payment.non_profit_id != id
      raise 'Cannot subtract unassociated Payment amount from NonProfit'
    end

    update!(unpaid_donation_amount: unpaid_donation_amount - payment.amount)
  end
end
