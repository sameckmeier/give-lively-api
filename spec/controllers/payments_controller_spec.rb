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
        non_profit = NonProfit.create!(name: 'Test', address: 'test')
        donation_1 = Donation.create!(amount: 1.0.to_d, non_profit_id: non_profit.id)
        donation_2 = Donation.create!(amount: 0.5.to_d, non_profit_id: non_profit.id)
        donation_3 = Donation.create!(amount: 2.0.to_d, non_profit_id: non_profit.id, payment_id: Digest::UUID.uuid_v4)

        post :create, params: { payment: { non_profit_id: non_profit.id, amount: 1.5.to_d }, format: 'json' }

        parsed_response = JSON.parse(response.body)['data']

        expect(parsed_response.key?('id')).to eq(true)
        expect(parsed_response['attributes']['non_profit_id']).to eq(non_profit.id)
        expect(parsed_response['attributes']['amount']).to eq('1.5')

        expect(non_profit.reload.unpaid_donation_amount.to_d).to eq(2.0.to_d)

        expect(donation_1.reload.payment_id).to eq(parsed_response['id'])
        expect(donation_2.reload.payment_id).to eq(parsed_response['id'])
        expect(donation_3.reload.payment_id).not_to eq(parsed_response['id'])
      end
    end
  end
end
