require 'test_helper'

class StockPricesControllerTest < ActionController::TestCase
  test "should create a new price" do
    st = StockTicker.create(name: StockTicker.generate_name)
    sp = StockPrice.new(date: DateTime.now, price: rand(1..1000), stock_ticker_id: st.id).save

    count_before = StockPrice.count
    
    post :create, {stock_price: {stock_ticker_id: st.id}, format: 'js'} 
    assert_response :success, 'Post on create should response success'
    
    count_after = StockPrice.count
    assert count_before + 1 == count_after, 'Stock price must be incremented'
  end

end
