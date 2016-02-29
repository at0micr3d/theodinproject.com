# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u1 = User.create(name: "owner 1", age: 10)
e1 = Event.create(description: "event 1", location: 'holland', date: Time.now, owner: u1)
u2 = e1.invitees.create(name: "part. 1", age: 11)
u3 = e1.invitees.create(name: "part. 2", age: 12)

u2 = User.create(name: "Fiene", age: 1)
20.times do |i|
	Event.create(description: "event future #{i}", location: "holland district #{i}", date: Time.now + i.days, owner: u2)
	Event.create(description: "event past #{i}", location: "holland district #{i}", date: Time.now - i.days, owner: u2)
end
