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

#CREATING EVENT_TYPE SEEDS
puts "Creating events types...."

puts "Creating 1st event type...."
  event_type = EventType.new(
    name:"Pill",
    description:"fa-capsules"
    )
  event_type.save

puts "Creating 2nd event type...."
  event_type = EventType.new(
    name:"Shot",
    description:"fa-user-md"
    )
  event_type.save

puts "Creating 3rd event type...."
  event_type = EventType.new(
    name:"Medical appointment",
    description:"fa-calendar-plus"
    )
  event_type.save

puts "Creating 4th event type...."
  event_type = EventType.new(
    name:"Other",
    description:"fa-bell"
    )
  event_type.save

#start id og event_type
event_type_start_id = EventType.first.id



#CREATING 3 USERS
puts "Creating users...."

#1st User
puts "Creating 1st user...."
user = User.new(
  first_name:"Rui",
  last_name:"Magalhães",
  email:"rui.magalhaes@gmail.com",
  simple_view: false,
  password:"1212**",
  admin: true
  )
user.remote_photo_url = "https://avatars2.githubusercontent.com/u/45366558?v=4"
user.save
puts "User 'Rui Magalhães' created successfully!"


#CREATE 3 EVENTS FOR THE 1 ST USER WITH RECURRING FALSE.
# puts "Creating 3 events for the 1st user..."
# puts "Creating 1st event for the 1st user..."
# event = Event.new(
#   name:"Take 1 brufene",
#   description:"brufene needed for healing your flu!",
#   start_time: Time.now + 17.minutes,
#   end_time: Time.now + 1.hour + 17.minutes,
#   recurring: false,
#   notify_before: true,
#   notify_done:false,
#   notify_missed:true,
#   user_id: user.id,
#   event_type_id: event_type_start_id
#   )
# event.save
# event.update(start_id: event.id)

# puts "Creating 2nd event for the 1st user..."
# event = Event.new(
#   name:"Blood test",
#   description:"appointment on 'hospital da luz' on Lisbon. Blood test!",
#   start_time: Time.now + 3.day,
#   end_time: Time.now + 3.day + 1.hour,
#   recurring: false,
#   notify_before: true,
#   minutes: 30,
#   notify_done:false,
#   notify_missed:true,
#   user_id: user.id,
#   event_type_id: event_type_start_id + 2
#   )
# event.save
# event.update(start_id: event.id)

# puts "Creating 3rd event for the 1st user..."
# event = Event.new(
#   name:"Blood test results",
#   description:"appointment on 'hospital da luz' on Lisbon to receive my blood test resuls!",
#   start_time: Time.now + 3.day + 1.week ,
#   end_time: Time.now + 3.day + 1.week + 1.hour,
#   recurring: false,
#   notify_before: true,
#   minutes: 30,
#   notify_done:false,
#   notify_missed:true,
#   user_id: user.id,
#   event_type_id: event_type_start_id + 2
#   )
# event.save
# event.update(start_id: event.id)

#2nd User (Father of the 1st)
puts "Creating 2nd user...."
user = User.new(
  first_name:"Manuel",
  last_name:"Magalhães",
  email:"manuel.magalhaes@gmail.com",
  simple_view: false,
  password:"1212**",
  admin: false
  )
user.remote_photo_url = "https://images.unsplash.com/photo-1523278669709-c05da80b6a65?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&h=800"
user.save
puts "User 'Manuel Magalhães' created successfully!"

# puts "creating the relation between Rui and Manuel. Rui is caretaker of Manuel and Manuel patient of Rui."

# #start id og event_type
# user_start_id = User.first.id

# 1.times do
#   relation = Relation.new()
#   relation.caretaker = User.find(user_start_id)
#   relation.patient = User.find(user_start_id + 1)
#   relation.state = true
#   relation.save
# end

# #CREATE EVENTS FOR THE 2ND USER.
# puts "Creating 2 events for the 2nd user..."
# puts "Creating 1st event for the 2nd user..."
# event = Event.new(
#   name:"Take flu vaccine",
#   description:"Flu vaccine at 'hospital da luz' on Lisbon.",
#   start_time: Time.now + 4.day,
#   end_time: Time.now + 4.day + 1.hour,
#   recurring: false,
#   notify_before: true,
#   notify_done:true,
#   notify_missed:true,
#   user_id: user.id,
#   event_type_id: event_type_start_id + 1
#   )
# event.save
# event.update(start_id: event.id)

# puts "Creating 2nd event for the 2nd user..."
# event = Event.new(
#   name:"Take high blood pressure pill",
#   description:"take 1 blood pressure pill every 24 hours!",
#   start_time: Time.now - 12.minutes,
#   end_time: Time.now - 12.minutes + 20.minutes,
#   recurring: false,
#   notify_before: true,
#   notify_done:true,
#   notify_missed:true,
#   user_id: user.id,
#   event_type_id: event_type_start_id
#   )
# event.save
# event.update(start_id: event.id)

#3rd User (Grandmother of the 1st)
puts "Creating 3rd user...."
user = User.new(
  first_name:"Maria",
  last_name:"Santos",
  email:"maria.santos@gmail.com",
  simple_view: false,
  password:"1212**",
  admin: false
  )
user.remote_photo_url = "https://images.unsplash.com/photo-1442458370899-ae20e367c5d8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&h=800"
user.save
puts "User 'Maria Santos' created successfully!"

#No events for the 3rd user















































