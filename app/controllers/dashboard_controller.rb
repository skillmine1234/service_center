class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!

  include ActionView::Helpers::TextHelper
  respond_to :html, :js, :json, :xml

  def overview
    @current_user = current_user
  end

  def version
    @list = Bundler.load.specs.select { |g| g.name.start_with?('qg-') }
    @rpm_version = rpm_version
  end

  def env_config
    if Rails.env.production?
      @config_env_vars = {}
      `service-center config`.split("\n").each do |e|
         key_value_arr = e.split("=",2)
         @config_env_vars[key_value_arr.first] = key_value_arr.second
      end
    else
      @config_env_vars = Dotenv.load
    end
  end
  
  def error_msg
    flash[:alert] = "Rule is not yet configured"
    redirect_to :root
  end
  
  private
  def rpm_version
    return Rails.env unless Rails.env.production?
    return `rpm -qa service-center --last`
  rescue
    ''
  end
end
