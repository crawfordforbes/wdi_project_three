require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'haml'

# call in models 

before do
  content_type :json
end

get("/") do
  content_type :html 
  haml :index 
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
  activity_json = JSON.parse(request.body.read) 
  Activity.create(
       event_id: activity_json["event_id"], 
        upvotes: 1, 
           name: activity_json["name"], 
        address: activity_json["address"], 
            url: activity_json["url"], 
    description: activity_json["description"], 
      window_id: activity_json["window_id"]

    ).to_json  
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

delete("/memberships/:id") do 
  Membership.find_by_id(params[:id]).destroy 
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