require "faker"

puts "Destroying every seed...."

Disease.destroy_all
UserDisease.destroy_all
Relation.destroy_all
Notification.destroy_all
Event.destroy_all
EventType.destroy_all
User.destroy_all

puts "Every seed destroyed"


puts "Creating 5 events type...."
#CREATING EVENT_TYPE SEEDS
5.times do
  event_type = EventType.new(name:Faker::Job.title ,description:Faker::Food.description)
  event_type.save
end

#start id og event_type
event_type_start_id = EventType.first.id
#end id og event_type
event_type_end_id = EventType.last.id



#CREATING 3 USERS WITHOUT PHOTO
3.times do
  puts "Creating user...."
  user = User.new(first_name:Faker::Artist.name ,last_name:Faker::App.author , email:Faker::Internet.safe_email, simple_view: true, password:"123456" )
  user.save

  #CREATE 5 EVENTS FOR EACH USER WITH NAME, DESCRIPTION, RECURRING, USER_ID AND EVENT_TYPE_ID.
  puts "Creating 5 events for user"
  5.times do
    #event_type_id assigned randomly
    event = Event.new(name:Faker::Esport.event ,description:Faker::Lorem.sentence , recurring: false, user_id: user.id, event_type_id:rand(event_type_start_id...event_type_end_id) )
    event.save
  end


end














































