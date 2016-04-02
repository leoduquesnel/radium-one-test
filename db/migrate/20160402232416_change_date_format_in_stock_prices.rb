class ChangeDateFormatInStockPrices < ActiveRecord::Migration
  def up
    change_column :stock_prices, :date, :date
  end

  def down
    change_column :stock_prices, :date, :datetime
  end
end
