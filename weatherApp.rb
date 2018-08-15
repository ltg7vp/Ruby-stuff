require 'open-uri'
require 'json'

#Weather API returns Kelvins so we'll have to use these conversion functions later on
def KelvinToCelcius(kelvin)
  return (kelvin - 273.15).round(2)
end

def KelvinToFahrenheit(kelvin)
  return (kelvin * 9/5 - 459.67).round(2)
end

params = Array.new
puts "Pass location parameters in the following format: '[City], [State]'"
print "> "
params << gets.chomp

if params.length != 1
  puts "Error: Parameters not formatted correctly.
  Please pass location parameters in the following format: '[City], [State]'"


else


  #Stringing together the arguments to fit into a URL
  search = Array.new
  params.each do |argv|
    search << argv
  end
  search = search.join

  #Putting together the URL
  baseurl =  "http://api.openweathermap.org/data/2.5/weather?q="
  appid = "&APPID=aade92db2619aca3f567b1ac542128b5"
  fullurl = "#{baseurl}#{search}#{appid}"

  #Read the data at the URL
  data = open(fullurl).read
  json = JSON.parse(data)

  #If the city isn't found, lets get out of here!
  if json['cod'] == 400
    abort("City not found. Please try again.")
  end

  #Assigning variables using conversion functions
  tempc = KelvinToCelcius(json["main"]["temp"])
  lowc = KelvinToCelcius(json["main"]["temp_min"])
  highc = KelvinToCelcius(json["main"]["temp_max"])

  tempf = KelvinToFahrenheit(json["main"]["temp"])
  lowf = KelvinToFahrenheit(json["main"]["temp_min"])
  highf = KelvinToFahrenheit(json["main"]["temp_max"])

  #Output to console
  puts ""
  puts " " * 8 + "Forecast for #{search}"
  puts " " * 10 + "Temperature (F°) #{tempf}° (hi: #{highf}/lo: #{lowf})"
  puts " " * 10 + "Temperature (C°) #{tempc}° (hi: #{highc}/lo: #{lowc})"
  puts ""
  puts " " * 10 + "Description: #{json['weather'].first['description']}"
  puts " " * 10 + "Wind: #{json['wind']['speed']} mph"
  puts " " * 10 + "Cloudiness: #{json['clouds']['all']}%"
  puts ""

end
