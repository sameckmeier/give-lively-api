# frozen_string_literal: true

module Api
  module V1
    class NonProfitsController < ApplicationController
      def index
        non_profits = NonProfit.all
        raise 'this is an error'
        if params[:requires_payment] == '1'
          non_profits = non_profits.requires_payment
        end

        render json: serializer.new(non_profits)
      rescue StandardError => e
        logger.error(e)
        render json: { error: 'There was an error fetching Non Profits' },
               status: :unprocessable_entity
      end

      def update
        non_profit = NonProfit.find(params[:id])

        non_profit.update!(non_profit_params)

        render json: serializer.new(non_profit)
      rescue StandardError => e
        logger.error(e)
        render json: { error: 'Could not update Non Profit' },
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
