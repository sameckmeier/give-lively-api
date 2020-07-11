# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::PaymentsController do
  describe 'create' do
    context 'when params are invalid' do
      it 'raises exception' do
        post :create, params: { format: 'json' }

        parsed_response = JSON.parse(response.body)

        expect(parsed_response.key?('error')).to eq(true)
      end
    end

    context 'when params are valid' do
      it 'creates record' do
        non_profit = NonProfit.create(name: 'Test', address: 'test', unpaid_donation_amount: 1.0.to_d)

        post :create, params: { payment: { non_profit_id: non_profit.id, amount: 1.0.to_d }, format: 'json' }

        parsed_response = JSON.parse(response.body)['data']

        expect(parsed_response.key?('id')).to eq(true)
        expect(parsed_response['attributes']['non_profit_id']).to eq(non_profit.id)
        expect(parsed_response['attributes']['amount']).to eq('1.0')
        expect(non_profit.reload.unpaid_donation_amount.to_d).to eq(0.0.to_d)
      end
    end
  end
end
