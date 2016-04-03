smokio-back-end
==

## How to set up the project:

`bundle install`

`rake db:create && rake:db migrate`

`rake stock_tickers:generate`
`rake stock_prices:generate`

You're ready

## Run tests

`RAILS_ENV=test rake db:create && rake:db migrate`

`rake test`