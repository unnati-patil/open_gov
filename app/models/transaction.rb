class Transaction < ApplicationRecord
  belongs_to :ledger

  # validations
  validates_presence_of :amount, :transaction_type
end
