class ProfilesController < ApplicationController
  before_action :set_users, only: [:index]
  # skip_after_action :verify_policy_scoped, only: :index

  def index
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  private

  def set_users
    @profiles = policy_scope(User)
  end
end
