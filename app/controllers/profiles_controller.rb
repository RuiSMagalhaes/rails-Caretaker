class ProfilesController < ApplicationController
  before_action :set_user, :set_patients, :set_notifications, only: [:index, :show, :edit]
  before_action :set_profile, only: [:show, :edit]
  # skip_after_action :verify_policy_scoped, only: :index

  def index
    # geting user events
    @events = set_events(@user)
    # geting all events for each patient
    @patients.each { |patient| @events += set_events(patient) }
  end

  def show
    authorize @profile
    # geting events for this profile
    @events = set_events(@profile)
    # geting notifications for this profile
    @notifications = @notifications.where(event_id: @events.pluck(:id))
  end

  def edit
    authorize @profile
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
    @events = policy_scope(user.events)
  end
end
