namespace :stock_tickers do
  desc "Generate some stock tickers"
  task :generate => :environment do
    30.times do |i|
      StockTicker.create(name: Array.new(4){[*"A".."Z"].sample}.join)
    end  
  end

end