# frozen_string_literal: true

# Transaction model
class Transaction < ApplicationRecord
  belongs_to :ledger

  # validations
  validates_presence_of :amount, :transaction_type
  validates_inclusion_of :transaction_type, in: %w( expense revenue ), message: 'must be either expense or revenue'

  scope :expenses, -> { where(transaction_type: 'expense') }
  scope :revenues, -> { where(transaction_type: 'revenue') }
  scope :total_expenses, ->(year, month) { expenses.where('extract(year  from created_at) = ? and extract(month from created_at) = ?', year, month) }
  scope :total_revenues, ->(year, month) { revenues.where('extract(year  from created_at) = ? and extract(month from created_at) = ?', year, month) }
  scope :count_expenses, -> { expenses.calculate(:sum, :amount) }
  scope :count_revenues, -> { revenues.calculate(:sum, :amount) }
end
