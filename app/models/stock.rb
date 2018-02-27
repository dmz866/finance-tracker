class Stock < ApplicationRecord
  def self.new_from_lookup(ticker_symbol)
    begin
      looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
      last_price = remove_commas(looked_up_stock.l)
      new(name: looked_up_stock.name, ticker: looked_up_stock.symbol, last_price: last_price)  
    rescue Exception => e
      return nil
    end
  end
  
  def self.remove_commas(num)
    num.gsub(",", "")
  end
end
