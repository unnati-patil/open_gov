# frozen_string_literal: true

# Ledger model
class Ledger < ApplicationRecord
  has_many :transactions, dependent: :destroy

  # validations
  validates :starting_balance, numericality: { greater_than_or_equal_to: 100 }
  validates_presence_of :name, :starting_balance

  def balance
    starting_balance + transactions.count_revenues - transactions.count_expenses
  end
end
