# frozen_string_literal: true

# factory for transactions
FactoryBot.define do
  trans_types = %w[expense revenue]
  desc = ['Purchase staplers', 'Parking meter fees']

  factory :transaction do
    amount { Faker::Number.number(10) }
    transaction_type { trans_types.sample }
    description { desc.sample }
  end
end
