class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :update, :destroy]

  def show
    authorize @notification
  end

  def destroy
    authorize @notification
    @notification.update(dismissed: true)
    redirect_to notification_path(@notification)
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
