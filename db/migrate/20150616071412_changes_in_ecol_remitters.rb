class ChangesInEcolRemitters < ActiveRecord::Migration
  def change
    rename_column :ecol_remitters, :remitter_name, :rmtr_name
    rename_column :ecol_remitters, :remitter_address, :rmtr_address
    rename_column :ecol_remitters, :remitter_acct_no, :rmtr_acct_no
    rename_column :ecol_remitters, :remitter_email, :rmtr_email
    rename_column :ecol_remitters, :remitter_mobile, :rmtr_mobile
    change_column :ecol_remitters, :due_date, :date
  end
end
