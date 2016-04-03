class DashboardController < ApplicationController
  def index
    @stock_tickers = StockTicker.select(:id, :name).order('name asc').page params[:page]
  end
end
