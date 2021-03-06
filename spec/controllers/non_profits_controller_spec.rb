# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::NonProfitsController do
  describe 'index' do
    it 'returns json collection' do
      NonProfit.create!(name: 'Test1', address: 'test')
      NonProfit.create!(name: 'Test2', address: 'test')

      get :index

      parsed_response = JSON.parse(response.body)['data']
      expect(parsed_response.length).to eq(2)
    end

    context 'when page param is set' do
      it 'returns paginated json collection' do
        page = 2

        10.times do |i|
          NonProfit.create!(name: "Member #{i}", address: "test #{i}", member: true)
        end

        get :index, params: { page: page, format: :json }

        parsed_response = JSON.parse(response.body)['data'].map { |non_profit| non_profit['id'].to_i }
        expected_ids = NonProfit.page(page).map(&:id)

        expect(parsed_response.length).to eq(NonProfit::PAGINATES_PER)
        expect(parsed_response).to contain_exactly(*expected_ids)
      end
    end

    context 'when requires_payments query param is present' do
      it 'returns filtered json collection' do
        NonProfit.create!(name: 'Test1', address: 'test')
        NonProfit.create!(name: 'Test2', address: 'test', unpaid_donation_amount: 1.50.to_d)
        NonProfit.create!(name: 'Test3', address: 'test', member: true)

        get :index, params: { requires_payment: '1', format: :json }

        parsed_response = JSON.parse(response.body)['data']

        expect(parsed_response.length).to eq(1)
        expect(parsed_response[0]['attributes']['unpaid_donation_amount']).to eq('1.5')
      end
    end
  end

  describe 'update' do
    it 'updates record' do
      non_profit = NonProfit.create!(name: 'Test', address: 'test')

      put :update, params: { id: non_profit.id, non_profit: { address: 'test 1' }, format: 'json' }

      parsed_response = JSON.parse(response.body)['data']

      expect(parsed_response['attributes']['address']).to eq('test 1')
    end
  end
end
