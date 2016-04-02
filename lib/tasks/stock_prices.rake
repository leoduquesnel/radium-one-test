namespace :stock_prices do
  desc "Generate some stock prices for all the available stock tickers"
  task :generate => :environment do
    start_date = Date.today.beginning_of_year
    end_date = start_date + 6.months

    (end_date - start_date).to_i.times do |i|
      StockTicker.all.each do |st|
        if st.stock_prices.present?
          StockPrice.create(stock_ticker: st, date: start_date + i.days, price: st.stock_prices.last.price * rand(0.80..1.20))        
        else
          StockPrice.create(stock_ticker: st, date: start_date + i.days, price: rand(1..1000))        
        end
      end
    end
    
  end

end