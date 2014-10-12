require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require_relative './db/connection'
require_relative './db/models.rb'
require 'active_support'
require 'active_record'

binding.pry