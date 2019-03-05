class NotificationsController < ApplicationController
  def show
    @notification = Notification.find(params[:id])
    authorize @notification
  end

  def dismissed
    @notification = Notification.find(params[:notification_id])
    @notification.update(dismissed: true)
    authorize @notification
    redirect_to notification_path(@notification)
  end
end
