class NotificationsController < ApplicationController
  def show
    @notification = Notification.find(params[:id])
    authorize @notification
  end
end
