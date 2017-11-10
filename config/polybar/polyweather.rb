require 'net/http'
require 'uri'
require 'json'

class Polyweather
  def initialize(api_key, lat, long)
    @api_key = api_key
    @lat = lat
    @long = long
  end

  def fetch
    url = "https://api.darksky.net/forecast/#{api_key}/#{lat},#{long}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    @result = JSON.parse(response.body)
  end

  def currently
    raise RuntimeError("Call fetch before calling currently") if result.nil?
    result["currently"]
  end

  def to_s
    puts "#{icon}\t #{temperature}\u{00B0}F\t #{summary}"
  end

  def temperature
    currently["temperature"]
  end

  def summary
    currently["summary"]
  end

  def icon
    case currently["icon"]
    when "clear-day" then "\uf185"
    when "clear-night" then "\uf185"
    when "rain" then "\u{f2cc}"
    when "snow" then "\u{f2dc}"
    when "sleet" then "\u{f2dc}"
    when "wind" then "\u{f050}"
    when "cloudy" then "\u{f0c2}"
    when "partly-cloudy-day" then "\u{f2cc}\u{f002}"
    when "partly-cloudy-night" then "\u{f2cc}\u{f086}"
    end
  end

  private

  attr_reader :api_key, :lat, :long, :result
end

begin
  p = Polyweather.new("5b6b96cc1b7dbdd2db851d95f8f2d3e9", "40.0756496", "-75.299668")
  p.fetch
  puts p.to_s
rescue
  nil
end