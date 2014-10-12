require_relative './db/connection.rb'
require_relative '/db/models.rb'

Event.delete_all
Activity.delete_all
Window.delete_all
Membership.delete_all
Person.delete_all

ln = Event.create({
	name: "Ladies Night"
	zipcode: "90015"
	deadline: 2014-10-17
	})

Window.create({
	event_id: ln.id,
	upvotes: 0,
	name: ""
	})