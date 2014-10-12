require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'haml'
require_relative './db/connection.rb'
require_relative './db/models.rb'

# call in models 

before do
  content_type :json
end

get("/") do
  content_type :html 
  erb(:index) 
end

# events 

get("/events") do 
  Event.all.to_json 
end 

post("/events") do
  event_json = JSON.parse(request.body.read)  
  Event.create(
    name: event_json["name"],
    zipcode: event_json["zipcode"],
    deadline: Date.new(event_json["deadline"])
    ).to_json
end 

delete("/events/:id") do 
  # send out the emails via sendgrid, etc, then 
  # destroy all associated objs 
  Membership.destroy_all(event_id: params[:id])
  Window.destroy_all(event_id: params[:id])
  Activity.destroy_all(event_id: params[:id])
  Event.destroy(params[:id]) 
end 

get("/events/:id") do 
  Event.find_by_id(params[:id]).to_json
end 

put("/events/:id") do 
  the_event = Event.find_by_id(params[:id])
  the_event.update(:upvotes, 
    the_event[:upvotes] + 1)
  the_event.to_json 
end 

get("/events/:id/activities") do 
  Activity.where(:event_id, params[:id]).to_json
end 

get("/events/:id/windows") do
  Window.where(:event_id, params[:id]).to_json 
end 

get("/events/:id/memberships") do 
  Membership.where(:event_id, params[:id]).to_json
end 

# activities # 

post("/activities") do


  # create zipcode and dates for api calls
  zipcode = params[:zipcode]
  date = params[:date]

  # converts zipcode to lat long for eventbrite api
  longlat = HTTParty.get("http://zipcodedistanceapi.redline13.com/rest/hDnZEdMTiTMIdufkYObXQUY134PG6pnn2KnGYaAh4nZhRfCQ3NNTIMVLQKrW9Okc/info.json/#{zipcode}/degrees")

  lat = longlat["lat"]
  long = longlat["lng"]

  # get events
  response = HTTParty.get("https://www.eventbriteapi.com/v3/events/search/?location.within=10mi&location.latitude=#{lat}&location.longitude=#{long}&start_date.range_start=#{date}T01%3A30%3A42Z&start_date.range_end=#{date}T23%3A30%3A42Z&token=3BS25F7EIU2IIB4YWQWF")

  # get 5 events, if the api is missing info autofill an error message
  eventBritecounter = 0
  while eventBritecounter < 6
    if response["events"][eventBritecounter]["venue"]["location"]["address_1"] != nil
      street = response["events"][eventBritecounter]["venue"]["location"]["address_1"]
    else street = "Street not found"
    end
    if response["events"][eventBritecounter]["venue"]["location"]["city"] != nil
      city = response["events"][eventBritecounter]["venue"]["location"]["city"]
    else city = "City not found"
    end
    if response["events"][eventBritecounter]["name"]["text"] != nil
      eventName = response["events"][eventBritecounter]["name"]["text"]
    else eventName = "Name not found"
    end
    if response["events"][eventBritecounter]["description"]["text"] != nil
      eventDescription = response["events"][eventBritecounter]["description"]["text"][0...200] + "..."
    else eventDescription = "Description not found"
    end
    if response["events"][eventBritecounter]["url"] != nil
      eventUrl = response["events"][eventBritecounter]["url"]
    else eventUrl = "URL not found"
    end

    #create the event database entry
    Activity.create({
      event_id: params[:id],
      upvotes: 0,
      name: eventName,
      description: eventDescription,
      address: street + ", " + city,
      url: eventUrl,
      window_id: Window.where(event_id: params[:id]).id
      })

    eventBritecounter += 1
  end


  eventfulResponse = HTTParty.get("http://api.eventful.com/json/events/search/?location=#{zipcode}&start_time=#{date}&end_time=#{date}&app_key=PXgMsX9vnshjM5Wv")
  eventfulResponse = JSON.parse(response)

  eventfulCounter = 0 
  while eventfulCounter < 6
    if eventfulResponse["events"]["event"][eventfulCounter]["venue_address"] != nil
      street = eventfulResponse["events"]["event"][eventfulCounter]["venue_address"]
    else street = "Street not found"
    end
    if eventfulResponse["events"]["event"][eventfulCounter]["city_name"] != nil
      city = eventfulResponse["events"]["event"][eventfulCounter]["city_name"]
    else city = "City not found"
    end
    if eventfulResponse["events"]["event"][eventfulCounter]["title"]  != nil
      eventName = eventfulResponse["events"]["event"][eventfulCounter]["title"] 
    else eventName = "Name not found"
    end
    if eventfulResponse["events"]["event"][eventfulCounter]["description"] != nil
      eventDescription = eventfulResponse["events"]["event"][eventfulCounter]["description"][0...200] + "..."
    else eventDescription = "Description not found"
    end
    if eventfulResponse["events"]["event"][eventfulCounter]["url"] != nil
      eventUrl = eventfulResponse["events"]["event"][eventfulCounter]["url"]
    else eventUrl = "URL not found"
    end
    Activity.create({
      event_id: params[:id],
      upvotes: 0,
      name: eventName,
      description: eventDescription,
      address: street + ", " + city,
      url: eventUrl,
      window_id: Window.where(event_id: params[:id]).id
      })
    eventfulCounter +=1
  end


  opentableResponse = HTTParty.get("http://opentable.herokuapp.com/api/restaurants?zip=#{zipcode}")

  opentableCounter = 0 
  while opentableCounter < 6
    if opentableResponse["restaurants"][opentableCounter]["address"]  != nil
      street = opentableResponse["restaurants"][opentableCounter]["address"] 
    else street = "Street not found"
    end
    if opentableResponse["restaurants"][opentableCounter]["city"]  != nil
      city = opentableResponse["restaurants"][opentableCounter]["city"] 
    else city = "City not found"
    end
    if opentableResponse["restaurants"][opentableCounter]["name"]  != nil
      eventName = opentableResponse["restaurants"][opentableCounter]["name"] 
    else eventName = "Name not found"
    end
    
    eventDescription = "Eat something delicious."
    
    
    if opentableResponse["restaurants"][opentableCounter]["reserve_url"] != nil
      eventUrl = opentableResponse["restaurants"][opentableCounter]["reserve_url"]
    else eventUrl = "URL not found"
    end

    Activity.create({
      event_id: params[:id],
      upvotes: 0,
      name: eventName,
      description: eventDescription,
      address: street + ", " + city,
      url: eventUrl,
      window_id: Window.where(event_id: params[:id]).id
      })

    opentableCounter +=1
  end





  # activity_json = JSON.parse(request.body.read) 
  # Activity.create(
  #  event_id: activity_json["event_id"], 
  #  upvotes: 1, 
  #  name: activity_json["name"], 
  #  address: activity_json["address"], 
  #  url: activity_json["url"], 
  #  description: activity_json["description"], 
  #  window_id: activity_json["window_id"]

  #  ).to_json  
end 

get("/activities") do 
  Activity.all.to_json
end

get("/activities/:id") do 
  Activity.where(window_id: params[:id]).to_json
end

put("/activities/:id") do 
  the_activity = Activity.find_by_id(params[:id])
  the_activity.update(:upvotes, 
    the_activity.upvotes + 1).to_json
end 

# windows # 

post("/windows") do
  window_json = JSON.parse(request.body.read)  
  Window.create(
    event_id: window_json["event_id"],
    upvotes: 0,
    day: Date.new(window_json["day"])
    ).to_json
end 

put("/windows/:id") do
  the_window = Window.find_by_id(params[:id])
  the_window.update(:upvotes, 
    the_window.upvotes + 1).to_json
end 

# memberships # 

post("/memberships") do
  membership_json = JSON.parse(request.body.read)  
  Membership.create(
    people_id: membership_json["people_id"],
    event_id: membership_json["event_id"]
    ).to_json 
end 

# people #

get("/people") do 
  Person.all.to_json
end 

post("/people") do
  person_json = JSON.parse(request.body.read)  
  Person.create(
   name: person_json["name"], 
   email: person_json["email"]
   ).to_json
end 

get("/people/:id") do 
  Person.find_by_id(params[:id]).to_json
end 