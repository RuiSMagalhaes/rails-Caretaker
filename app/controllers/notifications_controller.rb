class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show]

  def create


  end

  def show
    authorize @notification
  end

  def dismissed
    @notification = Notification.find(params[:notification_id])
    @notification.update(dismissed: true)
    authorize @notification
    redirect_to notification_path(@notification)
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
