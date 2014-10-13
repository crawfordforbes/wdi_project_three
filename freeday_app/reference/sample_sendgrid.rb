require 'active_record'

class Subscriber < ActiveRecord::Base

	end

def subscribe (subscribers, title)
  subscribers.each do |subscriber|
  response = HTTParty.post "https://sendgrid.com/api/mail.send.json", 
    :body => {
    "api_user" => "bdargan",
    "api_key" => "pjigglies915",
    "to" => "#{subscriber.email}",
    "toname"=> "#{subscriber.name}",
    "from" => "brenda@brendadargan.com",
    "subject" => "A new event has been created!",
    "text" => "Hi #{subscriber.name}! Invitation copy goes here."
      	};
  	end
end	


# SendGrid server info
  # subscribers = Subscriber.all()
  # title = posts_hash[:title]  
  # subscribe(subscribers, title)