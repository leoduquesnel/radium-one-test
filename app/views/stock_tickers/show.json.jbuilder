json.array! @stock_prices do |stock_price|
  json.date   stock_price.date.strftime('%d-%m-%Y')
  json.price  stock_price.price
end