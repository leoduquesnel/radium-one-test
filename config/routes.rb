Rails.application.routes.draw do

  root 'dashboard#index'

  resources :stock_tickers, only: [:show]
  resource :stock_prices, only: [:create]
end