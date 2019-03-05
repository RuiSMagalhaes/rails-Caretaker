class EventsController < ApplicationController
  before_action :set_user, :set_profile
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json
  def index
    set_events
    authorize @profile, :show?
  end

  # GET /events/1
  # GET /events/1.json
  def show
    authorize @profile
  end

  # GET /events/new
  def new
    @event = Event.new
    authorize @profile
  end

  # GET /events/1/edit
  def edit
    authorize @event
    authorize @profile
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user = @profile
    authorize @profile
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    authorize @profile
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    authorize @profile
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    params.require(:event).permit(:name, :start_time, :user_id, :event_type_id)
  end
end
