require 'rails_helper'

# Test suite for the Transaction model
RSpec.describe Transaction, type: :model do
	# test for association: transaction belongs to one ledger
	it { should belong_to(:ledger) }

	# validations test
	it { should validate_presence_of(:amount) }
	it { should validate_presence_of(:transaction_type) }
	# it { should validate_presence_of(:created_at) } 
end
