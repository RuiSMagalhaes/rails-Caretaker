class NotifyEventUserDoJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    # If the event_id is not populated in a database, is because the event has been deleted or updated (our updated method delete an event and creates a new one)
    # if I don't have an event, I don't want do do anything
    unless Event.where(id: event_id).nil?
      @event = Event.find(event_id)
      # notify the event user if he did not mark the event as done on the before job
      unless @event.done
        notification = Notification.new(event_id: @event.id, user_id: @event.user.id)
        notification.notification_type = "Do"
        notification.save
      end
    end
  end
end
