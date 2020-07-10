# frozen_string_literal: true

module Api
  module V1
    class NonProfitsController < ApplicationController
      def index
        non_profits = NonProfit.all

        if params[:requires_payment] == '1'
          non_profits = non_profits.requires_payment
        end

        render json: serializer.new(non_profits)
      rescue StandardError => e
        render json: { error: 'There was an error fetching Non Profits' },
               status: :unprocessable_entity
      end

      private

      def serializer
        NonProfitSerializer
      end
    end
  end
end
