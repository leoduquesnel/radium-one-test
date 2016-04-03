class DashboardController < ApplicationController
  def index
    cache @stock_tickers, expires_in: 5.minutes do
      @stock_tickers = StockTicker.select(:id, :name, :updated_at).order('name asc').page params[:page]
    end
  end
end
