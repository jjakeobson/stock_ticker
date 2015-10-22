require 'httparty'
require 'nokogiri'

class StockTicker
  def initialize(user_stock)
    @symbol = user_stock
    @stock = HTTParty.get("http://finance.yahoo.com/q?s=#{@symbol}")
    @dom = Nokogiri::HTML(@stock.body)
  end

  def get_current_price
    stock_price = @dom.xpath("//span[@id='yfs_l84_#{@symbol}']").first
    puts "Current Stock Price for #{@symbol.upcase}: $#{stock_price.content}"
  end

  def get_prev_close
    prev_close = @dom.xpath("//td[@class='yfnc_tabledata1']").first
    puts "Previous Closing Price for #{@symbol.upcase}: $#{prev_close.content}"
  end
end

print "What stock do you want to see? Please enter the symbol (ex: aapl for Apple): "
chosen_stock = gets.chomp
stockticker1 = StockTicker.new(chosen_stock)
stockticker1.get_current_price
stockticker1.get_prev_close
