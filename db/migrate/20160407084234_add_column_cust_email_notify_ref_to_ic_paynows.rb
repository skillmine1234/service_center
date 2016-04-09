class AddColumnCustEmailNotifyRefToIcPaynows < ActiveRecord::Migration
  def change
    add_column :ic_paynows, :cust_email_notify_ref, :string, :limit => 50, :comment => 'the unique number which sendemail app returns after sending email'    
  end
end
