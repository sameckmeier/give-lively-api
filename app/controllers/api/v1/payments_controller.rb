# frozen_string_literal: true

module Api
  module V1
    class PaymentsController < ApplicationController
      # POST /api/v1/payments
      # PARAMS: { payment: { non_profit_id: int }}
      # RESPONSE: { data: { id: string, type: string, attributes: { non_profit_id: int, amount: decimal, fulfilled: boolean }}}
      # DESC: Creates payment record, transfers amount from GiveLively account to non-member non-profit,
      #       subtracts amount from non-profit unpaid_donation_amount, and marks payment as fulfilled

      def create
        payment = Payment.create!(payment_params)

        payment.send_payment

        render json: serializer.new(payment)
      rescue StandardError => e
        logger.error(e)
        render json: { error: 'Could not create Payment' },
               status: :unprocessable_entity
      end

      private

      def serializer
        PaymentSerializer
      end

      def payment_params
        params.require(:payment).permit(:non_profit_id)
      end
    end
  end
end
