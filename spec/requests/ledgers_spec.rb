# frozen_string_literal: true

# spec/requests/ledgers_spec.rb
require 'rails_helper'

RSpec.describe 'Ledgers API', type: :request do
  # initialize test data
  let!(:ledgers) { create_list(:ledger, 10) }
  let(:ledger_id) { ledgers.first.id }

  # POST /ledgers
  describe 'POST /ledgers' do
    # valid payload
    let(:valid_attributes) { { name: 'San Francisco General Ledger', starting_balance: 100 } }

    context 'when the request is valid' do
      before { post '/ledgers', params: valid_attributes }

      it 'creates a ledger' do
        expect(JSON.parse(response.body)['name']).to eq('San Francisco General Ledger')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/ledgers', params: { name: 'CA General Ledger' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Starting balance is not a number, Starting balance can't be blank/)
      end
    end
  end
end
