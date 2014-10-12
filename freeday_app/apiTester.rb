require 'HTTParty'
require 'pry'

puts "Please enter a zip code:"

zipcode = gets.chomp


puts "Please enter an event date in this format: YYYY-MM-DD"

date = gets.chomp

endDay = date.split("-")[2].to_i + 1
endDate = date.split("-")[0] + "-" + date.split("-")[1] + "-" + endDay.to_s
puts "Please select an api by number: [1] Eventbrite -- [2] Eventful -- [3] Opentable"

option = gets.chomp

if option == "1"
	longlat = HTTParty.get("http://zipcodedistanceapi.redline13.com/rest/hDnZEdMTiTMIdufkYObXQUY134PG6pnn2KnGYaAh4nZhRfCQ3NNTIMVLQKrW9Okc/info.json/#{zipcode}/degrees")

	lat = longlat["lat"]
	long = longlat["lng"]

	response = HTTParty.get("https://www.eventbriteapi.com/v3/events/search/?location.within=10mi&location.latitude=#{lat}&location.longitude=#{long}&start_date.range_start=#{date}T12%3A30%3A42Z&start_date.range_end=#{endDate}T12%3A30%3A42Z&token=3BS25F7EIU2IIB4YWQWF")
	counter = 0
	while counter < 6
		if response["events"][counter]["venue"]["location"]["address_1"] != nil
			street = response["events"][counter]["venue"]["location"]["address_1"]
		else street = "Street not found"
		end
		if response["events"][counter]["venue"]["location"]["city"] != nil
			city = response["events"][counter]["venue"]["location"]["city"]
		else city = "City not found"
		end
		if response["events"][counter]["name"]["text"] != nil
			eventName = response["events"][counter]["name"]["text"]
		else eventName = "Name not found"
		end
		if response["events"][counter]["description"]["text"] != nil
			eventDescription = response["events"][counter]["description"]["text"][0...200] + "..."
		else eventDescription = "Description not found"
		end
		if response["events"][counter]["url"] != nil
			eventUrl = response["events"][counter]["url"]
		else eventUrl = "URL not found"
		end
		display = {
			name: eventName,
			description: eventDescription,
			address: street + ", " + city,
			url: eventUrl
		}

		puts display
		counter += 1
	end

end

if option == "2"
	response = HTTParty.get("http://api.eventful.com/json/events/search/?location=#{zipcode}&start_time=#{date}&end_time=#{endDate}&app_key=PXgMsX9vnshjM5Wv")
	response = JSON.parse(response)

	counter = 0 
	while counter < 6
		if response["events"]["event"][counter]["venue_address"] != nil
			street = response["events"]["event"][counter]["venue_address"]
		else street = "Street not found"
		end
		if response["events"]["event"][counter]["city_name"] != nil
			city = response["events"]["event"][counter]["city_name"]
		else city = "City not found"
		end
		if response["events"]["event"][counter]["title"]  != nil
			eventName = response["events"]["event"][counter]["title"] 
		else eventName = "Name not found"
		end
		if response["events"]["event"][counter]["description"] != nil
			eventDescription = response["events"]["event"][counter]["description"][0...200] + "..."
		else eventDescription = "Description not found"
		end
		if response["events"]["event"][counter]["url"] != nil
			eventUrl = response["events"]["event"][counter]["url"]
		else eventUrl = "URL not found"
		end
		display = {
			name: eventName,
			description: eventDescription,
			address: street + ", " + city,
			url: eventUrl
		}

		puts display
		counter += 1
	end
end

if option == "3"
	response = HTTParty.get("http://opentable.herokuapp.com/api/restaurants?zip=#{zipcode}")

	counter = 0 
	while counter < 6
		if response["restaurants"][counter]["address"]  != nil
			street = response["restaurants"][counter]["address"] 
		else street = "Street not found"
		end
		if response["restaurants"][counter]["city"]  != nil
			city = response["restaurants"][counter]["city"] 
		else city = "City not found"
		end
		if response["restaurants"][counter]["name"]  != nil
			eventName = response["restaurants"][counter]["name"] 
		else eventName = "Name not found"
		end
		
			eventDescription = "Eat something delicious."
		
		
		if response["restaurants"][counter]["reserve_url"] != nil
			eventUrl = response["restaurants"][counter]["reserve_url"]
		else eventUrl = "URL not found"
		end
		display = {
			name: eventName,
			description: eventDescription,
			address: street + ", " + city,
			url: eventUrl
		}

		puts display
		counter += 1
	end
end