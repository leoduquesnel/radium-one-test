require 'test_helper'

class StockTickersControllerTest < ActionController::TestCase
  test "should get show" do
    st = StockTicker.create(name: Array.new(4){[*"A".."Z"].sample}.join)
    30.times do |i|
      StockPrice.create(stock_ticker: st, date: Date.today + i.day, price: rand(1..1000))
    end

    get :show, id: st.id, format: 'json'
    assert_response :success, 'route works'

    get :show, id: st.id, format: 'json'
    assert JSON.parse(response.body).count == 30, 'normal results'

    get :show, id: st.id, limit: 10, format: 'json'
    assert JSON.parse(response.body).count == 10, '10 results'
  end
end