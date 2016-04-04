class StockPricesController < ApplicationController
  def create
    @stock_ticker = StockTicker.find_by_id(params[:stock_price][:stock_ticker_id].to_i)
    if @stock_ticker.present?
      last_stock_price = @stock_ticker.stock_prices.order('date desc').first
      if last_stock_price
        StockPrice.create(
            price: last_stock_price.price * rand(0.80..1.20),
            stock_ticker: @stock_ticker,
            date: last_stock_price.date + 1.day)
      else
        StockPrice.create(
            price: rand(1..1000),
            stock_ticker: @stock_ticker,
            date: Date.today)
      end
    end
    respond_to do |format|
      format.js
    end
  end
end
