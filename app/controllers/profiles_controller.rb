class ProfilesController < ApplicationController
  before_action :set_patients, only: [:index, :show]
  before_action :set_user, only: [:show]
  # skip_after_action :verify_policy_scoped, only: :index

  def index
    @profiles = [@user]
  end

  def show
    authorize @profile
  end

  private

  def set_user
    @profile = User.find(params[:id])
  end

  def set_patients
    @profiles = policy_scope(User)
  end
end
