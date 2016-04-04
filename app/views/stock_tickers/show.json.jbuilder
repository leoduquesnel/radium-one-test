json.array! @stock_prices do |stock_price|
  json.date   stock_price.date.strftime('%m-%d-%Y')
  json.price  stock_price.price
end