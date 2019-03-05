class ProfilesController < ApplicationController
  before_action :set_user, :patients, :notifications, only: [:index, :show]
  before_action :set_profile, only: [:show]
  # skip_after_action :verify_policy_scoped, only: :index

  def index
    # geting user events
    @events = events(@user)
    # geting all events for each patient
    @patients.each { |patient| @events += events(patient) }
  end

  def show
    authorize @profile
  end

  private

  def set_user
    @user = current_user
  end

  def set_profile
    @profile = User.find(params[:id])
  end

  def patients
    @patients = @user.patients
  end

  def notifications
    @notifications = @user.notifications
  end

  def events(user)
    @events = user.events
  end
end
