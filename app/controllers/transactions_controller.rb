class TransactionsController < ApplicationController
	before_action :set_ledger
  before_action :set_ledger_transaction, only: :show

   # GET /ledgers/:ledger_id/transactions
  def index
    json_response(@ledger.transactions)
  end

  # GET /ledgers/:ledger_id/transactions/:id
  def show
    json_response(@transaction)
  end

  # POST /ledgers/:ledger_id/transactions
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
end
