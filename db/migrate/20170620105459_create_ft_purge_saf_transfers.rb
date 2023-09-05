class CreateFtPurgeSafTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :ft_purge_saf_transfers do |t|# , {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :reference_no, limit: 100, null: false, comment: "the ID of the customer whose transactions are to be deleted"
      t.datetime :from_req_timestamp, null: false, comment: "the starting date for the request timestamp from which the transactions are to be deleted"
      t.datetime :to_req_timestamp, null: false, comment: "the ending date for the request timestamp upto which the transactions are to be deleted"
      t.string :customer_id, limit: 15, comment: "the ID of the customer whose transactions are to be deleted"
      t.string :op_name, limit: 32, comment: "the name of the operation whose transactions are to be deleted"
      t.string :req_transfer_type, limit: 4, comment: "the type of the transfer e.g. NEFT/IMPS/FT/RTGS whose transactions are to be deleted"

      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.datetime :updated_at, null: false, comment: "the timestamp when the record was last updated"
      t.string :created_by, limit: 20, comment: "the person who creates the record"
      t.string :updated_by, limit: 20, comment: "the person who updates the record"
      t.integer :lock_version, null: false, default: 0, comment: "the version number of the record, every update increments this by 1"     
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.string :approval_status, limit: 1, default: 'U', null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
      t.integer :approved_version, comment: "the version number of the record, at the time it was approved"
      t.integer :approved_id, comment: "the id of the record that is being updated"

      t.index([:reference_no, :approval_status], unique: true, name: 'ft_purge_saf_transfers_01')
    end
  end
end
