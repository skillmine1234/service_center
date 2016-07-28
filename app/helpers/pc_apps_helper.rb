module PcAppsHelper
  def find_pc_apps(params)
    pc_apps = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcApp.unscoped : PcApp
    pc_apps = pc_apps.where("pc_program_id=?",params[:pc_program_id]) if params[:pc_program_id].present?
    pc_apps = pc_apps.where("app_id=?",params[:app_id]) if params[:app_id].present?
    pc_apps
  end
end
