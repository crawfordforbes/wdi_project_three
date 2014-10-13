<<<<<<< HEAD
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require_relative './db/connection'
require_relative './db/models.rb'
require 'active_support'
require 'active_record'

binding.pry
=======
require_relative './lib/connection.rb'
require 'HTTParty'
require 'pry'
puts "zipcode?"
zip = gets.chomp
# zipcode = HTTParty.get("http://zipcodedistanceapi.redline13.com/rest/Fs5YoBH0OwMCmNXo3TjyhTQ6orybxCOd4TbtuTujpgVL3Sa7LuF3nv9MXHXukLIp/info.json/#{zip}/degrees")

# lat = zipcode["lat"]
# long = zipcode["lng"]

					# eventbrite api

# response = HTTParty.get("https://www.eventbriteapi.com/v3/events/search/?location.within=10mi&location.latitude=#{lat}&location.longitude=#{long}&start_date.range_start=2014-10-16T12%3A30%3A42Z&start_date.range_end=2014-10-21T12%3A30%3A48Z&token=3BS25F7EIU2IIB4YWQWF")
# binding.pry

# # [9] is interchangable
# # event name
# response["events"][9]["name"] 
# # event description
# response["events"][9]["description"]["text"] 
# # event address
# response["events"][9]["venue"]["location"]["address_1"] 
# # event city
# response["events"][9]["venue"]["location"]["city"] 
# # event link
# response["events"][9]["url"] 

					# eventful api
response = HTTParty.get("http://api.eventful.com/json/events/search/?location=#{zip}&start_time=2014-10-21&end_time=2014-10-23&app_key=PXgMsX9vnshjM5Wv")
response = JSON.parse(response)

# [7] is interchangable
# event name
response["events"]["event"][7]["title"] 
# event description
response["events"]["event"][7]["description"]
# event address
response["events"]["event"][7]["venue_address"]
# event city
response["events"]["event"][7]["city_name"]
# event url
response["events"]["event"][7]["url"] 



Gracenote API: Movie Times (by date and zip)
Key Rate Limits: 2 Calls per second; 50 Calls per day
API key: qpchaevyfxdypsd65kta5ta5

Replace startDate and zip:

movies = HTTParty.get("http://data.tmsapi.com/v1/movies/showings?startDate=2014-10-11&zip=11215&api_key=qpchaevyfxdypsd65kta5ta5")    

Replace [0] with variable when looping through:

movie_title = movies[0]["title"] 
short_description = movies[0]["shortDescription"]  
showtimes = movies[0]["showtimes"]                       
theater_name = movies[0]["showtimes"][0]["theatre"]["name"]   
date = movies[0]["showtimes"][0]["dateTime"].split("T")[0] 
time = movies[0]["showtimes"][0]["dateTime"].split("T")[1]  


OpenTable API

Replace zip:

restaurants = HTTParty.get("http://opentable.herokuapp.com/api/restaurants?zip=11215")

name = restaurants["restaurants"][0]["name"]
address = restaurants["restaurants"][0]["address"]  
city = restaurants["restaurants"][0]["city"] 
state = restaurants["restaurants"][0]["state"] 
zip = restaurants["restaurants"][0]["postal_code"]  
reservation_url = restaurants["restaurants"][0]["reserve_url"]
>>>>>>> 7cb348d10bad9adeea7350766b202e7dea4254e1
