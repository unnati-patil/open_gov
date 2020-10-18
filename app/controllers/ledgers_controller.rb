class LedgersController < ApplicationController
  # POST /todos
  def create
    @ledger = Ledger.create!(ledger_params)
    json_response(@ledger, :created)
  end

  def total
  end

  def current_balance
  end

  private

  def ledger_params
    # whitelist params
    params.permit(:name, :starting_balance)
  end
end
