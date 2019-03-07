class NotifyCaretakerAndEventUserMissedJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    # If the event_id is not populated in a database, is because the event has been deleted or updated (our updated method delete an event and creates a new one)
    # if I don't have an event, I don't want do do anything
    unless Event.where(id: event_id).nil?
      @event = Event.find(event_id)
      # unless event.done == true, I need to notify users of the event and caretakers that the event has been missed
      unless @event.done
        # dismiss every notification of the event to the user. It can be of the type "done" or "before"
        Notification.all.where(event_id: @event_id, user_id: @event.user.id).update(dismissed: true)
        # Notify the event user of the missed event
        notification = Notification.new(event_id: @event.id, user_id: @event.user.id)
        notification.notification_type = "missed"
        notification.save
        # notify all the caretakers
        @event.user.caretakers.each do |caretaker|
          # Dismiss every notification of this event for the caretakers. It can only be of the type "before".
          Notification.all.where(event_id: @event_id, user_id: caretaker.id, notification_type: "before").update(dismissed: true)
          # notify every caretaker of the event that the patient missed
          notification = Notification.new(event_id: @event.id, user_id: caretaker.id)
          notification.notification_type = "missed"
          notification.save
        end
      end
    end
  end
end
