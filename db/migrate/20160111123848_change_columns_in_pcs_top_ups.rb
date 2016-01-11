class ChangeColumnsInPcsTopUps < ActiveRecord::Migration
  def change
    remove_column :pcs_top_ups, :created_at
    remove_column :pcs_top_ups, :updated_at
    change_column :pcs_top_ups, :txn_uid, :string, :limit => 255, :comment => "the unique id of the debit transaction which MM api returns"
    change_column :pcs_top_ups, :debit_ref_no, :string, :limit => 255, :comment => "the reference number of the account debit, as seen in the account statement"
  end
end
