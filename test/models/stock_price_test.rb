# == Schema Information
#
# Table name: stock_prices
#
#  id              :integer          not null, primary key
#  date            :datetime
#  price           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  stock_ticker_id :integer
#

require 'test_helper'

class StockPriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
