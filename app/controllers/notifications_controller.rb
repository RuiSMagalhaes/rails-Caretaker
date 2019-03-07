class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :update, :destroy]

  def index
    set_user
    authorize @user, :show?
    set_notifications
    set_profile
    # if you have profile display only notifications for that profile
    unless @profile.nil?
      # get events for that profile
      set_events(@profile)
      # get notifications refering to that events
      @notifications = @notifications.where(event_id: @events.pluck(:id))
    end
  end

  def show
    authorize @notification
    set_from
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
        Notification.all.where(event_id: @event.id, user_id: caretaker.id, notification_type: "before").update(dismissed: true)
        # notify every caretaker of the event that the patient missed
        notification = Notification.new(event_id: event.id, user_id: caretaker.id)
        notification.notification_type = "done"
        notification.save
      end
    end
    refer = params[:refer].nil? ? request.referrer : params[:refer]
    redirect_to refer
  end

  def destroy
    authorize @notification
    # declare where you came before show page
    refer = params[:refer].nil? ? request.referrer : params[:refer]
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

  def set_profile
    # get profile user if you have the params
    unless params[:profile_id].nil?
      @profile = User.find(params[:profile_id])
    end
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def set_notifications
    # get all notifications for current user
    @notifications = policy_scope(@user.notifications).where(dismissed: false).order(created_at: :desc)
  end

  def set_events(user)
    # get events with given user
    @events = user.events
  end

  def set_from
    @refer = request.referrer
  end
end
