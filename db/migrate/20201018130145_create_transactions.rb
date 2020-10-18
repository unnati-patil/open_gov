class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :type
      t.text :description
      t.references :ledger, null: false, foreign_key: true

      t.timestamps
    end
  end
end
