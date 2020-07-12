# frozen_string_literal: true

module Api
  module V1
    class NonProfitsController < ApplicationController
      # GET /api/v1/non_profits
      # QUERY PARAMS: { requires_payment: 1 | 0 }
      # RESPONSE: { data: [{ id: int, type: string, attributes: { name: string, member: boolean, address: string, unpaid_donation_amount: decimal }}] }
      # DESC: Fetches all or filtered non-profits based on query params

      def index
        non_profits = NonProfit.all

        if params[:requires_payment] == '1'
          non_profits = non_profits.requires_payment
        end

        render json: serializer.new(non_profits)
      rescue StandardError => e
        logger.error(e)
        render json: { error: 'There was an error fetching NonProfits' },
               status: :unprocessable_entity
      end

      # PUT /api/v1/non_profits/:id
      # PARAMS: { id: int, non_profit: { address: string }}
      # RESPONSE: { id: int, type: string, attributes: { name: string, member: boolean, address: string, unpaid_donation_amount: decimal }}
      # DESC: Updates non-profit

      def update
        non_profit = NonProfit.find(params[:id])

        non_profit.update!(non_profit_params)

        render json: serializer.new(non_profit)
      rescue StandardError => e
        logger.error(e)
        render json: { error: 'Could not update NonProfit' },
               status: :unprocessable_entity
      end

      private

      def serializer
        NonProfitSerializer
      end

      def non_profit_params
        params.require(:non_profit).permit(:address)
      end
    end
  end
end
