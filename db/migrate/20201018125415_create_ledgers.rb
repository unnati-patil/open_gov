class CreateLedgers < ActiveRecord::Migration[6.0]
  def change
    create_table :ledgers do |t|
      t.string :name
      t.decimal :starting_balance

      t.timestamps
    end
  end
end
