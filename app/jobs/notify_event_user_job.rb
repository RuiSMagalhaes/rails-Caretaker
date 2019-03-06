class NotifyEventUserJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find(999999)
    # If event is nill, is because the event has been deleted or updated (our updated method delete an event and creates a new one)
    # if it's nill, I don't want do do anything
    put "lala"
    unless event.nil?



    end
  end
end
