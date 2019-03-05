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
  event_type = EventType.new(
    name:Faker::Job.title,
    description:Faker::Food.description
    )
  event_type.save
end

#start id og event_type
event_type_start_id = EventType.first.id
#end id og event_type
event_type_end_id = EventType.last.id


i = 1
#CREATING 3 USERS WITHOUT PHOTO
3.times do
  puts "Creating user...."
  user = User.new(
    first_name:Faker::Artist.name,
    last_name:Faker::App.author,
    email:"email#{i}@caretaker.pt",
    simple_view: true,
    password:"123456"
    )
  user.remote_photo_url = "https://thispersondoesnotexist.com/image"
  user.save
  i += 1
  #CREATE 5 EVENTS FOR EACH USER WITH RECURRING FALSE. MINUTES, HOURS, DAYS, WEEKS, MONTHS, START_ID NOT POPULATED
  puts "Creating 5 events for this user..."
  5.times do
    #event_type_id assigned randomly
    event = Event.new(
      name:Faker::Esport.event,
      description:Faker::Lorem.sentence,
      start_time: Faker::Time.between(Time.now, Time.now + 1),
      end_time: Faker::Time.between(Time.now + 2, Time.now + 3 ),
      recurring: false,
      notify_before:[true, false].sample,
      notify_done:[true, false].sample,
      notify_missed:[true, false].sample,
      user_id: user.id,
      event_type_id:rand(event_type_start_id...event_type_end_id),
      done:[true, false].sample
      )
    event.save
  end
end


#start id og event_type
event_start_id = Event.first.id
#end id og event_type
event_end_id = Event.last.id

#start id og event_type
user_start_id = User.first.id
#end id og event_type
user_end_id = User.last.id

puts "creating 50 notifications..."
#Create 50 notifications
50.times do
  notification = Notification.new(dismissed: false)
  notification.event = Event.find(rand(event_start_id...event_end_id))
  notification.user = User.find(rand(user_start_id...user_end_id))
  notification.save
end












































