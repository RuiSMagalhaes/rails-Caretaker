class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :last_notification, only: [:index, :full_index, :show]

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def default_url_options
  { host: ENV["HOST"] || "localhost:3000" }
  end

  protected

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :simple_view, :photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :simple_view, :photo])
  end

  def set_time_zone
    Time.zone = current_user.time_zone
  end

  private

  def last_notification
    @user = current_user
    authorize @user, :show?
    @notification = policy_scope(@user.events_notifications).where("events.done = ? AND notifications.dismissed = ? AND (notifications.notification_type LIKE ? OR notifications.notification_type LIKE ?)", false, false, "do", "missed").order(created_at: :asc).first
    unless @notification.nil?
      redirect_to profile_notification_path(@user, @notification)
    end
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
