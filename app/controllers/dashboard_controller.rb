class DashboardController < ApplicationController
  def index
    @stock_tickers = StockTicker.all.page params[:page]
  end
end
