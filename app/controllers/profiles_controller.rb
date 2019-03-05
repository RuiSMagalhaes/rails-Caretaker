class ProfilesController < ApplicationController
  before_action :set_user, :set_patients, :set_notifications, only: [:index, :show]
  before_action :set_profile, only: [:show]
  # skip_after_action :verify_policy_scoped, only: :index

  def index
    # geting user events
    @events = set_events(@user)
    # geting all events for each patient
    @patients.each { |patient| @events += events(patient) }
  end

  def show
    @events = set_events(@profile)
    @notifications = @notifications.where(event_id: @events.pluck(:id))
    authorize @profile
    raise
  end

  private

  def set_user
    @user = current_user
  end

  def set_profile
    @profile = User.find(params[:id])
  end

  def set_patients
    @patients = policy_scope(@user.patients)
  end

  def set_notifications
    @notifications = policy_scope(@user.notifications)
  end

  def set_events(user)
    @events = user.events
  end
end
