# frozen_string_literal: true

class NonProfit < ApplicationRecord
  validates :name, presence: true

  scope :requires_payment, -> { where(member: true).where('unpaid_donation_amount > ?', 0.00) }
end
