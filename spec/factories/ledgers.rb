# frozen_string_literal: true

# factory for ledgers
FactoryBot.define do
  factory :ledger do
    name { Faker::Name.name }
    starting_balance { Faker::Number.number(digits: 100) }
  end
end
