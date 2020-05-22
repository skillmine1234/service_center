class ApplicationController < ActionController::Base
  include SecureHeaders
  include Pundit
  protect_from_forgery
  ensure_security_headers
  helper_method :current_ability
  before_action :set_as_private
  before_action :authenticate_user!, if: :protected_by_pundit
  
  after_action :verify_authorized, except: :index, if: :protected_by_pundit
  # after_action :verify_policy_scoped, only: :index, if: :protected_by_pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from CanCan::AccessDenied, with: :user_not_authorized

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def set_as_private
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate, pre-check=0, post-check=0, max-age=0, s-maxage=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
  end

  def sign_out(*args)
    #to invalidate session on sign out
    current_user.update_attribute(:unique_session_id, "") unless current_user.nil?
    current_admin_user.update_attribute(:unique_session_id, "") unless current_admin_user.nil?   
    super
  end

  def block_inactive_user!
    if current_user.unregistered?
      redirect_to "/inactive.html"
    end
  end

  def authenticate_inactive_active_admin_user!
    unless current_admin_user.nil?
      if current_admin_user.inactive
        redirect_to "/inactive.html"
      end
    end
  end
 
  def current_ability
    @current_ability ||= Ability.new(current_user,params[:group_name])
  end
  
  def block_screens
    if ENV['CONFIG_ENVIRONMENT'] != 'test'
      flash[:alert] = "Access denied. You are not authorized to access the requested page."
      redirect_to root_path
    end
  end

  private

  def protected_by_pundit
    false
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
