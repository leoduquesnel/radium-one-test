class StockTickersController < ApplicationController
  def show
    @stock_prices = []
    stock_ticker = StockTicker.find_by_id(params[:id].to_i)
    
    if stock_ticker.present?
      @stock_prices = stock_ticker.stock_prices.select(:price, :date).order('date asc').to_a
    end

    respond_to do |format|
      format.json
    end
  end
end
