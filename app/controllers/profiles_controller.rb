class ProfilesController < ApplicationController
  before_action :set_user, :set_patients, :set_notifications, only: [:index, :show]
  before_action :set_profile, only: [:show, :edit]
  # skip_after_action :verify_policy_scoped, only: :index

  def index
    # geting user events
    set_events(@user)
    # geting all events for each patient
    @patients.each { |patient| @events += set_events(patient) }
    @events.sort_by { |start_time| start_time[:start_time]}
    # getting all pending requests
    set_pending_requests(@user)
  end

  def show
    authorize @profile, :edit?
    # geting events for this profile
    set_events(@profile)
    # geting notifications for this profile
    @notifications = @notifications.where(event_id: @events.pluck(:id)).order(created_at: :desc)
    set_pending_requests(@user)
  end

  def update
    @user = current_user
    authorize @user, :show?
    @user.simple_view ? @user.update(simple_view: false) : @user.update(simple_view: true)
    redirect_to profiles_path
  end

  private

  def set_user
    # set this user
    @user = current_user
  end

  def set_profile
    # get profile user
    @profile = User.find(params[:id])
  end

  def set_patients
    # get all patientes for current user
    @patients = policy_scope(@user.patients)
  end

  def set_notifications
    # get all notifications for current user only not dismissed and ordered by date
    @notifications = policy_scope(@user.notifications).where(dismissed: false).order(created_at: :desc)
  end

  def set_events(user)
    # get events with given user
    @events = policy_scope(user.events).order(start_time: :asc)
  end

  def set_pending_requests(user)
    @pendings = user.pending_caretaker_requests.where.not(sender_id: user.id)
    @pendings += user.pending_patient_requests.where.not(sender_id: user.id)
    @pendings = @pendings.empty?
  end
end
