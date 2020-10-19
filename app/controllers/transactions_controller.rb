# frozen_string_literal: true

# Tansaction controller
class TransactionsController < ApplicationController
  before_action :set_ledger
  before_action :set_ledger_transaction, only: :show
  before_action :validate_balance, only: :create

  # GET /ledgers/:ledger_id/transactions
  def index
    json_response(@ledger.transactions)
  end

  # GET /ledgers/:ledger_id/transactions/:id
  def show
    json_response(@transaction)
  end

  # POST /ledgers/:ledger_id/transaction
  def create
    transaction = @ledger.transactions.create!(transaction_params)
    json_response(transaction, :created)
  end

  private

  def transaction_params
    params.permit(:amount, :transaction_type, :description)
  end

  def set_ledger
    @ledger = Ledger.find(params[:ledger_id])
  end

  def set_ledger_transaction
    @transaction = @ledger.transactions.find_by!(id: params[:id]) if @ledger
  end

  def validate_balance
    if params[:transaction_type].eql?('expense') &&
      @ledger.balance < params[:amount].to_i
      json_response(message: "In sufficient balance. Current balance is: #{@ledger.balance}")
    end
  end
end
