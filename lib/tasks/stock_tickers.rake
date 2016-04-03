namespace :stock_tickers do
  desc "Generate some stock tickers"
  task :generate => :environment do
    30.times do |i|
      StockTicker.create(name: StockTicker.generate_name)
    end  
  end

end