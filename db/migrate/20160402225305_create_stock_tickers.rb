class CreateStockTickers < ActiveRecord::Migration
  def change
    create_table :stock_tickers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
