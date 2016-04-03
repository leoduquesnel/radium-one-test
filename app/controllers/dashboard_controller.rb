class DashboardController < ApplicationController
  def index
    @stock_tickers = StockTicker.all.order('name asc').page params[:page]
  end
end
