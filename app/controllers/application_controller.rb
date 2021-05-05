# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  # noinspection RailsParamDefResolve
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Allows for extra values to be taken at signup, add more to keys if needed
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name uin user_type])
  end

  # Sends users to new_user_session_url after sign out
  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_url
  end

  def confirm_logged_in(message = nil)
    if user_signed_in?
      redirect_to_login('You must be confirmed to see this page') unless current_user.check_confirmed?
    else
      redirect_to_login(message)
    end
  end

  protected def confirm_freshman(message = nil)
    redirect_to_home(message) unless user_signed_in? && current_user.check_freshman?
  end

  def confirm_staff(message = nil)
    redirect_to_home(message) unless user_signed_in? && current_user.check_staff?
  end

  def confirm_event_staff(event, message = nil)
    unless user_signed_in? && current_user.check_staff? && (current_user.committee_id.eql? event.committee_id)
      redirect_to_home(message)
    end
  end

  def confirm_exec(message = nil)
    redirect_to_home(message) unless user_signed_in? && current_user.check_executive?
  end

  def confirm_admin(message = nil)
    redirect_to_home(message) unless user_signed_in? && current_user.check_admin?
  end

  def redirect_to_home(message = nil)
    redirect_to root_path, alert: message.nil? ? 'You do not have permissions' : message
  end

  def redirect_to_login(message = nil)
    redirect_to new_user_session_path,
                alert: message.nil? ? 'You do not have permissions' : message
  end
end
