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

