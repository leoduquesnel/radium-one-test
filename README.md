Radium One Test by Léo Duquesnel
==

## How to set up the project:

`bundle install`

`rake db:create && rake:db migrate`

`rake stock_tickers:generate` (it creates 30 new stock tickers)

`rake stock_prices:generate` (it creates stock prices for all the stocks for 6 month, based on the beginning of the year)

You're ready

## Run tests

`RAILS_ENV=test rake db:create && rake:db migrate`

`rake test`