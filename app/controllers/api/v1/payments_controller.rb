# frozen_string_literal: true

module Api
  module V1
    class PaymentsController < ApplicationController
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
        params.require(:payment).permit(:non_profit_id, :amount)
      end
    end
  end
end
