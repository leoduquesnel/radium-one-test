class ChangeFormatOfPriceInStockPrice < ActiveRecord::Migration
  def up
    change_column :stock_prices, :price, :float
  end

  def down
    change_column :stock_prices, :price, :integer
  end
end
