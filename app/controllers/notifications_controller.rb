class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :update]

  def update
    authorize @notification
    # get the event relative to this notification
    event = @notification.event
    # update the event.done to true
    event.done.update(done: true)
    # if the option: "notify if done" is turned on, a notification has to be sent to every caretaker when the event turn to : done
    if event.notify_done
      # iterate through caretakers and create a notification for each one
      event.user.caretakers.each do |caretaker|
        notification = Notification.new(event_id: event.id, user_id: caretaker.id)
        notification.type = "done"
        notification.save
      end
    end

  end

  def show
    authorize @notification
  end

  def dismissed
    @notification = Notification.find(params[:notification_id])
    @notification.update(dismissed: true)
    authorize @notification
    redirect_to notification_path(@notification)
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
