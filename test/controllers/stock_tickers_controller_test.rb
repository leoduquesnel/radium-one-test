require 'test_helper'

class StockTickersControllerTest < ActionController::TestCase
  test "should get show" do
    st = StockTicker.create(name: StockTicker.generate_name)
    30.times do |i|
      StockPrice.create(stock_ticker: st, date: Date.today + i.day, price: rand(1..1000))
    end

    get :show, id: st.id, format: 'json'
    assert_response :success, 'route works'

    get :show, id: st.id, format: 'json'
    assert JSON.parse(response.body).count > 0, 'normal results'
  end
end