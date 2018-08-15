require 'open-uri'
require 'json'
require 'colorize'

params = Array.new
puts "Enter tick"
print "> "
params << gets.chomp

if false

else


  #Stringing together the arguments to fit into a URL
  search = Array.new
  params.each do |argv|
    search << argv
  end
  search = search.join

  #Putting together the URL
  #https://api.iextrading.com/1.0/stock/market/batch?types=quote&symbols=aapl,nflx,fb
  baseurl =  "https://api.iextrading.com/1.0/stock/"
  endURL = "/quote"
  fullurl = "#{baseurl}#{search}#{endURL}"

  #puts fullurl

  #Read the data at the URL
  data = open(fullurl).read
  json = JSON.parse(data)

  if json['cod'] == 400
    abort("City not found. Please try again.")
  end

percent = json['changePercent'] * 100
percent.round(4)

#Output
puts ""
puts "Company: #{json['companyName']}(#{json['symbol']})"
puts "Sector: #{json['sector']}"
puts ""
puts "Latest Price: #{json['latestPrice']}"
puts "Open: #{json['open']}"
puts "Close: #{json['close']}"
puts "High: #{json['high']}"
puts "Low: #{json['low']}"
puts ""
  if percent >= 0
    puts "Change: #{percent}%".green
  else
    puts "Change: #{percent}%".red
  end
puts ""




end
