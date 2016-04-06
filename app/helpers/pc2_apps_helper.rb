module Pc2AppsHelper
  def find_pc2_apps(params)
    pc2_apps = (params[:approval_status].present? and params[:approval_status] == 'U') ? Pc2App.unscoped : Pc2App
    pc2_apps = pc2_apps.where("app_id=?",params[:app_id]) if params[:app_id].present?
    pc2_apps
  end
end
