class NotifyCaretakerAndEventUserMissedJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    # If the event_id is not populated in a database, is because the event has been deleted or updated (our updated method delete an event and creates a new one)
    # if I don't have an event, I don't want do do anything
    unless Event.where(id: event_id).nil?
      @event = Event.find(event_id)
      # unless event.done == true, I need to notify users of the event and caretakers that the event has been missed
      unless @event.done
        # Notify the event user
        notification = Notification.new(event_id: @event.id, user_id: @event.user.id)
        notification.notification_type = "missed"
        notification.save
        # notify all the caretakers
        @event.user.caretakers.each do |caretaker|
          notification = Notification.new(event_id: @event.id, user_id: caretaker.id)
          notification.notification_type = "missed"
          notification.save
        end
      end
    end
  end
end
