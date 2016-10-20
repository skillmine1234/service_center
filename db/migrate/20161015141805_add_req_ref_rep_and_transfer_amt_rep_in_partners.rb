class AddReqRefRepAndTransferAmtRepInPartners < ActiveRecord::Migration
  def up
    add_column :partners, :add_req_ref_in_rep, :string, :limit => 1, :comment => 'the flag to indicate whether the element needs to be added in response'
    db.execute "UPDATE partners SET add_req_ref_in_rep = 'N'"
    change_column :partners, :add_req_ref_in_rep, :string, :limit => 1, :null => false, :default => 'Y', :comment => 'the flag to indicate whether the element needs to be added in response'

    add_column :partners, :add_transfer_amt_in_rep, :string, :limit => 1, :comment => 'the flag to indicate whether the element needs to be added in response'
    db.execute "UPDATE partners SET add_transfer_amt_in_rep = 'N'"
    change_column :partners, :add_transfer_amt_in_rep, :string, :limit => 1, :null => false, :default => 'Y', :comment => 'the flag to indicate whether the element needs to be added in response'
  end

  def down
    remove_column :partners, :add_req_ref_in_rep
    remove_column :partners, :add_transfer_amt_in_rep
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
