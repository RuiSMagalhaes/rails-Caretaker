require "faker"

puts "Destroying every seed...."

Disease.destroy_all
UserDisease.destroy_all
Relation.destroy_all
Event.destroy_all
Notification.destroy_all
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
    password:"123456",
    admin: i == 1
    )
  user.remote_photo_url = "https://thispersondoesnotexist.com/image"
  user.save
  puts "User #{i} created successfully!"
  i += 1
  #CREATE 5 EVENTS FOR EACH USER WITH RECURRING FALSE. MINUTES, HOURS, DAYS, WEEKS, MONTHS, START_ID NOT POPULATED
  puts "Creating 5 events for this user..."
  5.times do
    #event_type_id assigned randomly
    event = Event.new(
      name:Faker::Esport.event,
      description:Faker::Lorem.sentence,
      start_time: Time.now + 1.hour,
      end_time: Time.now + 2.hour,
      recurring: false,
      notify_before:[true, false].sample,
      notify_done:[true, false].sample,
      notify_missed:[true, false].sample,
      user_id: user.id,
      event_type_id:rand(event_type_start_id...event_type_end_id)
      )
    event.save
    puts "Event #{event.id} for user #{i} created successfully!"
  end
end

puts "creating 1 relation for first pair of users (caretacker > patient)..."

#start id og event_type
user_start_id = User.first.id

1.times do
  relation = Relation.new()
  relation.caretaker = User.find(user_start_id)
  relation.patient = User.find(user_start_id + 1)
  relation.save
end








































