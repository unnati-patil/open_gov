# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.5.3

* Rails version: 6.0.3

* System dependencies postgres 

* Database creation: rails db:create

* Database migration: rails db:migrate

* How to run the test suite: bundle exec rspec 

## Asumptions:

* I have assumed that starting balance for ledger is always greater than or equal to 100
* I am not passing date while creating transaction. I am assuming that we can create transactions only for current date and not for past or future dates. 
I am using created_at filed for fetching transaction date.
* If current balance is less than expense amount of new transaction, then I am not allowing to create transaction. 


## API Documentation:

* Create Ledger: POST
```
URL: /ledgers
Parameters: name: string, starting_balance: decimal

Request:
localhost:3000/ledgers?name=US special Ledger&starting_balance=100.00

Response:
{
    "id": 6,
    "name": "US special Ledger",
    "starting_balance": "100.0",
    "created_at": "2020-10-19T12:44:02.104Z",
    "updated_at": "2020-10-19T12:44:02.104Z"
}

Request:
localhost:3000/ledgers?name='Florida ledger'&starting_balance=10

Response:
{
    "message": "Validation failed: Starting balance must be greater than or equal to 100"
}
```

* Create Transaction: POST
```
URL: /ledgers/id/transactions
Parameters: amount: decimal, transaction_type: string(expense/revenue), description: text

Request:
localhost:3000/ledgers/6/transactions?amount=50&transaction_type=expense&description=pensils

Response:
{
    "id": 20,
    "amount": "50.0",
    "transaction_type": "expense",
    "description": "pensils",
    "ledger_id": 6,
    "created_at": "2020-10-19T12:47:36.238Z",
    "updated_at": "2020-10-19T12:47:36.238Z"
}

Request:
localhost:3000/ledgers/6/transactions?amount=150&transaction_type=revenue&description=pensils

Response:
{
    "id": 21,
    "amount": "150.0",
    "transaction_type": "revenue",
    "description": "pensils",
    "ledger_id": 6,
    "created_at": "2020-10-19T12:48:20.946Z",
    "updated_at": "2020-10-19T12:48:20.946Z"
}

Request:
localhost:3000/ledgers/6/transactions?amount=50&transaction_type=revnue&description=pensils

Response:
{
    "message": "Validation failed: Transaction type must be either expense or revenue"
}

Request:
localhost:3000/ledgers/6/transactions?amount=500&transaction_type=expense&description=pensils

Response:
{
    "message": "In sufficient balance. Current balance is: 200.0"
}
```

* List Transactions: GET
```
URL: ledgers/id/transactions

Request:
localhost:3000/ledgers/6/transactions

Response:
[
    {
        "id": 20,
        "amount": "50.0",
        "transaction_type": "expense",
        "description": "pensils",
        "ledger_id": 6,
        "created_at": "2020-10-19T12:47:36.238Z",
        "updated_at": "2020-10-19T12:47:36.238Z"
    },
    {
        "id": 21,
        "amount": "150.0",
        "transaction_type": "revenue",
        "description": "pensils",
        "ledger_id": 6,
        "created_at": "2020-10-19T12:48:20.946Z",
        "updated_at": "2020-10-19T12:48:20.946Z"
    },
    {
        "id": 22,
        "amount": "50.0",
        "transaction_type": "expense",
        "description": "pensils",
        "ledger_id": 6,
        "created_at": "2020-10-19T12:54:51.084Z",
        "updated_at": "2020-10-19T12:54:51.084Z"
    }
]
```

* Get ledger total: GET
```
*URL:* /ledgers/id/total
Parameters: year: year(2020), month: month(10)

Request:
localhost:3000/ledgers/6/total?year=2020&month=10

Response:
{
    "expenses": "100.0",
    "revenues": "150.0"
}

Request:
localhost:3000/ledgers/1/total?year=2020&month=9

Response:
{
    "expenses": "10.0",
    "revenues": "0.0"
}

Request:
localhost:3000/ledgers/6/total?year=2025&month=15

Response:
{
    "expenses": "0.0",
    "revenues": "0.0"
}
```

* Get current balance: GET
```
URL: /ledgers/id/current_balance

Request:
ledgers/1/current_balance

Response:
{
    "balance": "342.6"
}

Request:
localhost:3000/ledgers/6/current_balance

Response:
{
    "balance": "150.0"
}
```
