# == Schema Information
#
# Table name: stock_prices
#
#  id              :integer          not null, primary key
#  date            :date
#  price           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  stock_ticker_id :integer
#

require 'test_helper'

class StockPriceTest < ActiveSupport::TestCase
  test "should have every attributes to be saved" do
    sp = StockPrice.new
    assert_not sp.save
    
    st = StockTicker.create(name: StockTicker.generate_name)
    if st.present?
      sp = StockPrice.new(date: DateTime.now, price: rand(1..1000), stock_ticker_id: st.id)
      assert sp.save
    end
  end

  test "should have price > 0" do
    st = StockTicker.create(name: StockTicker.generate_name)
    if st.present?
      sp = StockPrice.new(date: DateTime.now, price: -12, stock_ticker_id: st.id)
      assert_not sp.save
    end
  end
end
