# frozen_string_literal: true

class Payment < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :non_profit
  has_many :donations

  validates :amount, presence: true, numericality: { greater_than: 0.0.to_d }

  after_create :associate_donations

  def send_payment
    # TODOD: Implement deposit functionality to allow GiveLively to transfer funds from payments account to non-member non profit
  end

  private

  def associate_donations
    donations = non_profit.donations.unfulfilled

    donations.update_all(payment_id: id, fulfilled: true, updated_at: DateTime.now)
  rescue StandardError => e
    logger.error(e)
    raise ActiveRecord::Rollback
  end
end
