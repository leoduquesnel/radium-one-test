class DashboardController < ApplicationController
  def index
    cache do :stock_tickers, expires_in: 5.minutes do
      @stock_tickers = StockTicker.select(:id, :name).order('name asc').page params[:page]
    end
  end
end
