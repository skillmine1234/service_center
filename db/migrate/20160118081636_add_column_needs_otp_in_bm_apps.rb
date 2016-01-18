class AddColumnNeedsOtpInBmApps < ActiveRecord::Migration
  def change
    add_column :bm_apps, :needs_otp, :string, :limit => 1
    db.execute "UPDATE bm_apps SET needs_otp = 'N'"
    change_column :bm_apps, :needs_otp, :string, :limit => 1, :default => 'N', :null => false, :comment => 'the flag to indicate whether otp is required or not'
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
