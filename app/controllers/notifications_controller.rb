class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :update, :destroy]

  def index
    set_user
    authorize @user, :show?
    set_notifications
  end

  def show
    authorize @notification
    @refer = request.referrer
  end

  def update
    authorize @notification
    # get the event relative to this notification
    event = @notification.event
    # update the event.done to true
    event.update(done: true)
    # if the option: "notify if done" is turned on, a notification has to be sent to every caretaker when the event turn to : done
    if event.notify_done
      # iterate through caretakers and create a notification for each one
      event.user.caretakers.each do |caretaker|
        notification = Notification.new(event_id: event.id, user_id: caretaker.id)
        notification.notification_type = "done"
        notification.save
      end
    end
    redirect_to notification_path
  end

  def destroy
    refer = params[:refer].nil? ? request.referrer : params[:refer]
    authorize @notification
    # change value notification to dismissed
    @notification.update(dismissed: true)
    # redirecto to the page where the action is implemented
    redirect_to refer
  end

  private

  def set_user
    # set this user
    @user = current_user
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def set_notifications
    # get all notifications for current user
    @notifications = policy_scope(@user.notifications).where(dismissed: false).order(created_at: :asc)
  end
end
