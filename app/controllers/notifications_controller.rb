class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :update, :destroy]
  before_action :set_user, :set_notifications, only: [:index, :full_index, :last_notification]
  skip_before_action :last_notification, only: [:show]

  def index
    set_profile
    authorize @profile, :show?
    set_last_notification
    if @notification.nil?
      set_events(@profile)
      @notifications = @notifications.where(event_id: @events.pluck(:id))
    else
      redirect_to profile_notification_path(@user, @notification)
    end
  end

  def full_index
    authorize @user, :edit?
  end

  def show
    authorize @notification
  end

  def update
    authorize @notification
    # get the event relative to this notification
    event = @notification.event
    # update the event.done to true
    event.update(done: true)
    # Dismiss notification of the user of the event
    @notification.update(dismissed: true)
    # if the option: "notify if done" is turned on, a notification has to be sent to every caretaker when the event turn to : done
    if event.notify_done
      # iterate through caretakers and create a notification for each one
      event.user.caretakers.each do |caretaker|
        # Dismiss every notification of this event for the caretakers of the type "before". I want to see the missed ones.
        Notification.all.where(event_id: event.id, user_id: caretaker.id, notification_type: "before").update(dismissed: true) unless Notification.all.where(event_id: event.id, user_id: caretaker.id, notification_type: "before").nil?
        # notify every caretaker of the event that the patient missed
        notification = Notification.new(event_id: event.id, user_id: caretaker.id)
        notification.notification_type = "done"
        notification.save
      end
    end
    redirect_to profiles_path
  end

  def destroy
    authorize @notification
    # declare where you came before show page
    params[:refer].nil? ? refer = request.referrer : refer = params[:refer]
    # change value notification to dismissed
    @notification.update(dismissed: true)
    # redirecto to the page where the action is implemented
    redirect_to profiles_path
  end

  private

  def set_user
    # set this user
    @user = current_user
  end

  def set_profile
    # get profile user if you have the params
    @profile = User.find(params[:profile_id])
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def set_last_notification
    @notifification = @notifications.where(notification_type: "do").last
  end

  def set_notifications
    # get all notifications for current user
    @notifications = policy_scope(@user.notifications).where(dismissed: false).order(created_at: :desc)
  end

  def set_events(user)
    # get events with given user
    @events = user.events
  end
end
