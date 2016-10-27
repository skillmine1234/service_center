class AddRequiredColumnsToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :app_code, :string, :limit => 20, :comment => "the name of the applicaion which will be required to send a notification"   
    add_column :partners, :notify_on_status_change, :string, :limit => 1, :comment => "the indicator to denote whether the alert has to be sent to partner on the transaction status changes"     
  end
end
