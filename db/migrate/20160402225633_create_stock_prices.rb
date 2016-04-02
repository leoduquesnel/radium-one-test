class CreateStockPrices < ActiveRecord::Migration
  def change
    create_table :stock_prices do |t|
      t.datetime :date
      t.integer :price

      t.timestamps null: false
    end
  end
end
