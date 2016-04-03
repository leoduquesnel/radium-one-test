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
  paginates_per 10
  
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :stock_prices

  def to_s
    name
  end
end
