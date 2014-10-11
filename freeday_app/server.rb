require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'httparty'
require_relative './db/connection'
require_relative './lib/???'
require 'active_support'

after do
  ActiveRecord::Base.connection.close
end

before do
  content_type :json
end

get("/") do

end

