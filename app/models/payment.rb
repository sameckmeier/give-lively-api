# frozen_string_literal: true

class Payment < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :non_profit
  has_many :donations

  validate :validate_non_profit_is_non_member, on: :create
  after_create :associate_donations

  def send_payment
    raise 'Cannot send Payment that is already fulfilled' if fulfilled

    # TODO: Implement deposit functionality to allow GiveLively to transfer funds from payments account to non-member non-profit

    non_profit.subtract_payment(self)
    update!(fulfilled: true)
  end

  private

  def validate_non_profit_is_non_member
    errors.add(:non_profit, 'is member') if non_profit.member
  end

  def associate_donations
    donations = non_profit.donations.requires_payment
    donations_sum = donations.reduce(0.0.to_d) { |sum, donation| sum + donation.amount }

    raise 'Donations sum must be greater than 0' if donations_sum.zero?

    donations.update_all(payment_id: id, updated_at: DateTime.now)
    update!(amount: donations_sum)
  rescue StandardError => e
    logger.error("Failed to associate Donations to Payment: #{e}")
    raise ActiveRecord::Rollback
  end
end
