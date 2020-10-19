# frozen_string_literal: true

# spec/requests/transactions_spec.rb
require 'rails_helper'

RSpec.describe 'Transactions API' do
  # Initialize the test data
  let!(:ledger) { create(:ledger) }
  let!(:transactions) { create_list(:transaction, 20, ledger_id: ledger.id) }
  let(:ledger_id) { ledger.id }
  let(:id) { transactions.first.id }

  # Test for GET /ledgers/:ledger_id/transactions
  describe 'GET /ledgers/:ledger_id/transactions' do
    before { get "/ledgers/#{ledger_id}/transactions" }

    context 'when ledger exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all ledger transactions' do
        expect(JSON.parse(response.body).size).to eq(20)
      end
    end

    context 'when ledger does not exist' do
      let(:ledger_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Ledger/)
      end
    end
  end

  # Test suite for GET /ledgers/:ledger_id/transactions/:id
  describe 'GET /ledgers/:ledger_id/transactions/:id' do
    before { get "/ledgers/#{ledger_id}/transactions/#{id}" }

    context 'when ledger transaction exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the transaction' do
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when ledger transaction does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Transaction/)
      end
    end
  end

  # Test for PUT /ledgers/:ledger_id/transactions
  describe 'POST /ledgers/:ledger_id/transactions' do
    let(:valid_attributes) { { amount: 10.00, transaction_type: 'revenue', description: 'rent' } }

    context 'when request attributes are valid' do
      before { post "/ledgers/#{ledger_id}/transactions", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/ledgers/#{ledger_id}/transactions", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Amount can't be blank/)
      end
    end
  end
end
