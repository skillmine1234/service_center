class RemoveColumnAppCodeFromRcTransferSchedule < ActiveRecord::Migration
  def change
    find_or_create_rc_app('RcTransferSchedule')
    remove_column :rc_transfer_schedule, :app_code
    find_or_create_rc_app('RcTransfer')
    remove_column :rc_transfers, :app_code
  end
  
  private
  
  def find_or_create_rc_app(model)
    app_codes = model.constantize.unscoped.pluck('distinct app_code')
    app_codes.each do |code|
      rc_app = RcApp.find_or_create_by(app_id: code)
      rc_app.reload
      model.constantize.unscoped.where(app_code: code).each do |rc|
        rc.update(rc_app_id: rc_app.id)
      end
    end
  end
end
