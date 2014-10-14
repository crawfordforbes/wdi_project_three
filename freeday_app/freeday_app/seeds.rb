require_relative './db/connection.rb'
require_relative '/db/models.rb'

Event.delete_all
Activity.delete_all
Window.delete_all
Membership.delete_all
Person.delete_all

ev = Event.create({
	name: "Ladies Night",
	zipcode: "90015",
	deadline: "2014-10-17"
	})

wi = Window.create({
	event_id: ev.id,
	upvotes: 0,
	day: "2014-11-3"
	})

ac = Activity.create({
	event_id: ev.id,
	upvotes: 0,
	name: "Golden Girls Improv",
	address: "8 24th st, New York",
	url: "http://newyorkcity.eventful.com/events/four-broads-and-cheesecake-golden-girlsprov-111-/E0-001-074445546-0?utm_source=apis&utm_medium=apim&utm_campaign=apic",
	description: "The Girls eat cheesecake",
	window_id: wi.id
	})

pe = Person.create({
	name: "Diane Keaton",
	email: "DKeaton@gmail.com"
	})

me = Membership.create({
	people_id: pe.id,
	event_id: ev.id
	})