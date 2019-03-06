class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :update, :destroy]

  def show
    authorize @notification
  end

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
        notification.notification_type = "done"
        notification.save
      end
    end
  end

  def destroy
    authorize @notification
    @notification.update(dismissed: true)
    redirect_to notification_path(@notification)
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
