# frozen_string_literal: true

# Ledger class
class LedgersController < ApplicationController
	before_action :set_ledger, only: %i[total current_balance]

  # POST /Ledger
  def create
    @ledger = Ledger.create!(ledger_params)
    json_response(@ledger, :created)
  end

  # GET /Legder/id/total
  def total
  	expenses = @ledger.transactions.total_expenses(params[:year], params[:month])
  	revenues = @ledger.transactions.total_revenues(params[:year], params[:month])
  	json_response(expenses: expenses.count_expenses, revenues: revenues.count_revenues)
  end

  # GET /Legder/id/current_balance
  def current_balance
  	json_response(balance: @ledger.balance)
  end

  private

  def set_ledger
    @ledger = Ledger.find(params[:id])
  end

  def ledger_params
    # whitelist params
    params.permit(:name, :starting_balance)
  end
end
