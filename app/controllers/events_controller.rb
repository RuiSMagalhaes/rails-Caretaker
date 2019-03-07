class EventsController < ApplicationController
  before_action :set_user
  before_action :set_profile, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_event, :set_events, only: [:show, :edit, :update, :destroy]

  def index
    authorize @profile, :show?
    @events = set_events
  end

  def schedule
    authorize @user, :show?
    # geting user events
    @events = set_all_events(@user)
    # set patients
    @patients = set_patients
    # geting all events for each patient
    @patients.each { |patient| @events += set_all_events(patient) }
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

  def set_patients
    # get all patientes for current user
    @patients = policy_scope(@user.patients)
  end

  def set_all_events(user)
    # get events with given user
    @events = user.events
  end

  def create_first(event)
    # add profile user to the event
    @event = event
    @event.user = @profile
    # validation if saved
    if @event.save
      # add start_id to event
      @event.update(start_id: @event.id)
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
end
