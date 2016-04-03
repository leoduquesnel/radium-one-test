class StockTickersController < ApplicationController
  def show
    @stock_prices = []
    stock_ticker = StockTicker.find_by_id(params[:id].to_i)
    
    if stock_ticker.present?
      limit = params[:limit].to_i > 0 ? params[:limit] : 30
      cache @stock_prices do
        @stock_prices = stock_ticker.stock_prices.select(:price, :date).order('date desc').limit(limit).to_a
      end
    end

    respond_to do |format|
      format.json
    end
  end
end
