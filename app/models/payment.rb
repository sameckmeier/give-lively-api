# frozen_string_literal: true

class Payment < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :non_profit
  has_many :donations

  validates :amount, presence: true, numericality: { greater_than: 0.0.to_d }

  validate :validate_non_profit_is_non_member, on: :create
  after_create :associate_donations

  def send_payment
    # TODO: Implement deposit functionality to allow GiveLively to transfer funds from payments account to non-member non-profit

    non_profit.subtract_payment(amount)
    update!(fulfilled: true)
  end

  private

  def validate_non_profit_is_non_member
    errors.add(:non_profit, 'is member') if non_profit.member
  end

  def associate_donations
    donations = non_profit.donations.requires_payment

    donations.update_all(payment_id: id, updated_at: DateTime.now)
  rescue StandardError => e
    logger.error(e)
    raise ActiveRecord::Rollback
  end
end
