class StockTickersController < ApplicationController
  def show
    @stock_prices = []
    stock_ticker = StockTicker.find_by_id(params[:id].to_i)
    
    if stock_ticker.present?
      limit = params[:limit].to_i > 0 ? params[:limit] : 30
      @stock_prices = stock_ticker.stock_prices.order('date desc').limit(limit)
    end

    respond_to do |format|
      format.json
    end
  end
end