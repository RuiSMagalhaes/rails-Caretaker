class EventsController < ApplicationController
  before_action :set_user, :set_profile
  before_action :set_event, :set_events, only: [:show, :edit, :update, :destroy]

  def index
    authorize @profile, :show?
    set_events
  end

  def show
    authorize @profile
  end

  # GET /events/new
  def new
    authorize @profile
    @event = Event.new
  end

  def create
    authorize @profile
    # create new event with params from form
    @event = Event.new(event_params)
    # call create first event to process at least one event
    create_first(@event)
  end

  def edit
    authorize @profile
    # select the first event of a series of events so the displayed info relates to the first one
    @event = @events.where(start_id: @event.start_id).first
  end

  def update
    authorize @profile
    # select all events with the start id
    @events = @events.where(start_id: @event.start_id)
    # clean db so previous events will removed
    @events.destroy_all
    # create new event with params from form
    @event = Event.new(event_params)
    # call create first event to process at least one event
    create_first(@event)
  end

  def destroy
    authorize @profile
    # destroy all events with the same start id
    @events.where(start_id: @event.start_id).destroy_all
    redirect_to profile_events_path(@profile), notice: 'Event was successfully destroyed.'
  end

  private

  def set_user
    @user = current_user
  end

  def set_profile
    @profile = User.find(params[:profile_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_events
    # get events with given user
    @events = policy_scope(@profile.events)
  end

  def create_first(event)
    # add profile user to the event
    @event = event
    @event.user = @profile
    # validation if saved
    if @event.save
      # add start_id to event
      @event.start_id = @event.id
      @event.save
      # call the jobs methods
      job_event_to_notification(@event)
      # call creation of multiple events
      create_multiple(@event) if @event.recurring
      # redirect to event
      redirect_to profile_event_path(@profile, @event), notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def create_multiple(event)
    # defining number of times that event is recurring
    times = event.recurring_times - 1
    # run the event save until number of times is 0
    until times.zero?
      # duplicate last event added
      next_event = event.dup
      # define hours, days, weeks and months
      next_event.hours.nil? ? hours = 0.hours : hours = next_event.hours.hours
      next_event.days.nil? ? days = 0.days : days = next_event.days.days
      next_event.weeks.nil? ? weeks = 0.weeks : weeks = next_event.weeks.weeks
      next_event.months.nil? ? months = 0.months : months = next_event.months.months
      # sum the time space to start_time and end_time
      next_event.start_time = next_event.start_time + hours + days + weeks + months
      next_event.end_time = next_event.end_time + hours + days + weeks + months
      # save event to db
      next_event.save
      # call the jobs methods
      job_event_to_notification(next_event)
      # define the event as the last saved event
      event = next_event
      # remove on time from iteration
      times -= 1
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name,
                                  :description,
                                  :start_time,
                                  :user_id,
                                  :event_type_id,
                                  :end_time,
                                  :recurring,
                                  :recurring_times,
                                  :notify_before,
                                  :notify_done,
                                  :done,
                                  :notify_missed,
                                  :minutes,
                                  :hours,
                                  :days,
                                  :weeks,
                                  :months)
  end

  def job_event_to_notification(event)
    # Call a Job for the user of the event (event.user) to notify (type:DO) him on time = event.start_time (if event.done == false => see this only in the job)
    NotifyEventUserDoJob.set(wait_until: event.start_time).perform_later(event.id)
    # If notify_before is true, the user of the event has to be notified as well as all his caretakers
    if event.notify_before
      # TODO: Call a Job to create a notification to the user and to his caretakers some time (defined by event.minutes) before the event.start_time
      # if a user do not populate the minutes field, it's 15min as a default. this notification will pop up 15 min before the start time of the event
      event.minutes = 15.minute if event.minutes.nil?
      # call the Job the the caretakers of the user and for the user of the event
      NotifyCaretakerAndEventUserBeforeJob.set(wait_until: event.start_time - event.minutes).perform_later(event.id)
    end
    # If notify_missed is true, the user of the event has to be notified as well as all his caretakers
    # TODO: Call a Job to create notifications for the user of the event his caretakers 15 minutes after the event.start_time (if done == false => check this on the Job only)
    NotifyCaretakerAndEventUserMissedJob.set(wait_until: event.start_time + 15.minute).perform_later(event.id) if event.notify_missed
    # if notify_done is true, all the caretakers of the user of the event need to be notified when the user of the event press the button "Done"
    # this logic is on the notification controller
  end
end
