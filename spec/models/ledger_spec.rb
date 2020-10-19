# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Ledger model
RSpec.describe Ledger, type: :model do
	# test for association: one ledger has many transactions
	it { should have_many(:transactions).dependent(:destroy) }

	# validations test
	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:starting_balance) }
end
