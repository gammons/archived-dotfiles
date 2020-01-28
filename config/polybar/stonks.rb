require 'net/http'
require 'uri'
require 'json'
require 'byebug'

# {"Global Quote"=>{"01. symbol"=>"TSLA", "02. open"=>"571.8900", "03. high"=>"583.9500", "04. low"=>"561.2500", "05. price"=>"581.5600", "06. volume"=>"11267493", "07. latest trading day"=>"2020-01-22", "08. previous close"=>"547.2000", "09. change"=>"34.3600", "10. change percent"=>"6.2792%"}}

class Stonks
  def initialize(api_key, stock)
    @api_key = api_key
    @stock = stock
  end

  def fetch
    url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{@stock}&apikey=#{@api_key}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    @price = result["Global Quote"]["05. price"].to_f
    @percent_change = result["Global Quote"]["10. change percent"].to_f
  end

  def to_s
    arrow = @percent_change > 0 ? "↑" : "↓"
    puts "#{@stock}: $#{"%.1f" % @price} (#{arrow}#{"%.1f" % @percent_change}%)"
  end
end

begin
  stock = Stonks.new("LHOBSQS63T3BNXII", ARGV[0])
  stock.fetch
  puts stock.to_s
rescue
  nil
end
