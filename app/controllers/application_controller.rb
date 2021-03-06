class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize
  before_filter :set_page_vars

  delegate :allow?, to: :current_permission
  helper_method :allow?

  def after_sign_in_path_for(resource)
    if request.referer == new_user_session_url
      projects_by_zipcode_path(resource.zip_code)
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || projects_by_zipcode_path(resource.zip_code)
    end
  end

private
  def current_permission
    @current_permission ||= Permissions.permission_for(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    unless current_permission.allow?(params[:controller], params[:action], current_resource)
      redirect_to root_url, alert: 'Not authorized.'
    end
  end

  def set_page_vars
    @body_class = [params[:controller], params[:action]].join(' ')
  end
end
