class EventsController < ApplicationController
  before_action :set_user, :set_profile
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json
  def index
    authorize @profile, :show?
    set_events
  end

  # GET /events/1
  # GET /events/1.json
  def show
    authorize @profile
  end

  # GET /events/new
  def new
    authorize @profile
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    authorize @profile
  end

  # POST /events
  # POST /events.json
  def create
    authorize @profile
    @event = Event.new(event_params)
    @event.user = @profile
    if @event.save
      #if saved, call the job_event_to_notification method
      job_event_to_notification(@profile)
      redirect_to profile_event_path(@profile, @event), notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    authorize @profile
    if @event.update(event_params)
      redirect_to profile_event_path(@profile, @event), notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    authorize @profile
    @event.destroy
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name,
                                  :description,
                                  :start_time,
                                  :user_id,
                                  :event_type_id,
                                  :end_time,
                                  :recurring,
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

  def job_event_to_notification(profile)
    # Call a Job for the user of the event (event.user) to notify him on time = event.start_time if event.done == false
    # Call a Job for the caretakers of the user of the event (event.user.caretakers) to notify them on time = event.start_time if event.done == false

    # If profile.notify_before is true, the user of the event has to be notified as well as all his caretakers
    if profile.notify_before
      # TODO: Call a Job to create a notification to the user and to his caretakers some time (defined by event.minutes) before the event.start_time
      # call the Job for the user of the event (event.user)
      # call the Job the the caretakers of the user of the event (event.user.caretakers)
    end

    # If profile.notify_missed is true, the user of the event has to be notified as well as all his caretakers
    if profile.notify_missed
      # TODO: Call a Job to create a notification to his caretakers 15 minutes after the event.start_time if done == false

    end
  end
end
