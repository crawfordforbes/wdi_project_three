require 'active_record'

ActiveRecord::Base.establish_connection({
  :adapter => "postgresql",
  :host => "localhost",
  :username => "crawford",
  :database => "freeDay"
})

ActiveRecord::Base.logger = Logger.new(STDOUT)
