require 'rubygems'
require 'httparty'
require 'nokogiri'


class StockTicker
  include HTTParty
  include Nokogiri

  attr_reader :current_price_ticker, :user_stock

  def initialize(user_stock)
    @stock = HTTParty.get("http://finance.yahoo.com/q?s=#{@user_stock}")

  end

  @dom = Nokogiri::HTML(@stock.body)

  def get_current_price
    stock_price = @dom.xpath("//span[@id='yfs_l84_#{@user_stock}']").first
    puts "Current Stock Price for #{@user_stock.upcase}: $#{stock_price.content}"
  end

  def get_prev_close
    prev_close = @dom.xpath("//td[@class='yfnc_tabledata1']").first
    puts "Previous Closing Price for #{@user_stock.upcase}: $#{prev_close.content}"
  end
end

print "What stock do you want to see? Please enter the symbol (ex: aapl for Apple): "
chosen_stock = gets.chomp
# get_current_price
# get_prev_close
stockticker1 = StockTicker.new(chosen_stock)
stockticker1.get_current_price
stockticker1.get_prev_close
