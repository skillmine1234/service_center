class AddColumnNotifyStatusBmsTables < ActiveRecord::Migration
  def change
    add_column :bms_add_beneficiaries, :notify_status, :string, limit: 50, comment: 'the status code for enqueueing alert.' 
    add_column :bms_del_beneficiaries, :notify_status, :string, limit: 50, comment: 'the status code for enqueueing alert.' 
    add_column :bms_mod_beneficiaries, :notify_status, :string, limit: 50, comment: 'the status code for enqueueing alert.'         
  end
end