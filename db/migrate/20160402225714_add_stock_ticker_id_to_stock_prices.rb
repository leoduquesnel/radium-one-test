class AddStockTickerIdToStockPrices < ActiveRecord::Migration
  def change
    add_column :stock_prices, :stock_ticker_id, :integer
    add_index :stock_prices, :stock_ticker_id
  end
end
