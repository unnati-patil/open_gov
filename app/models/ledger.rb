class Ledger < ApplicationRecord
  has_many :transactions, dependent: :destroy

  # validations
  validates_presence_of :name, :starting_balance
end
