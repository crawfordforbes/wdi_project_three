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
end 

post("/events") do 
end 

# we haven't talked about deleting events,
# maybe the delete event logic 
# should include sending out the final 
# report via SendGrid, etc. before 
# actual deletion - CRA  
delete("/events/:id") do 
end 

get("/events/:id") do 
end 

put("/events/:id") do 
end 

get("/events/:id/activities") do 
end 

get("/events/:id/windows") do 
end 

get("/events/:id/memberships") do 
end 

# activities # 

post("/activities") do 
end 

# not including a delete route for activities 
# activities are deleted when an event is 

put("/activities/:id") do 
end 

# windows # 

post("/windows") do 
end 

put("/windows") do 
end 

# for some reason it seems more reasonable 
# to me one might   
delete("/windows") do 
end 

# memberships # 

post("/memberships") do 
end 

# people #

get("/people") do 
end 

post("/people") do 
end 

get("/people/:id") do 
end 