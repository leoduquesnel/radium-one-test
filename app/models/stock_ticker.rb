# == Schema Information
#
# Table name: stock_tickers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StockTicker < ActiveRecord::Base
  validates_presence_of :name
end
