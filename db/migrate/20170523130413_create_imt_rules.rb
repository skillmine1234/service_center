class CreateImtRules < ActiveRecord::Migration
  def change
    create_table :imt_rules, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
    	t.string :cod_account_no, :limit => 20, :null => false, :comment => "the bank pool account which gets debited for settlement"
    	t.string :stl_gl_account, :limit => 20, :null => false, :comment => "the bank gl account which gets credited for settlement"
      t.datetime :created_at, null: false, comment: "the timestamp when the record was created"
      t.datetime :updated_at, null: false, comment: "the timestamp when the record was last updated"
      t.string :created_by, limit: 20, comment: "the person who creates the record"
      t.string :updated_by, limit: 20, comment: "the person who updates the record"
      t.integer :lock_version, null: false, default: 0, comment: "the version number of the record, every update increments this by 1"
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.string :approval_status, limit: 1, default: 'U', null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
      t.integer :approved_version, comment: "the version number of the record, at the time it was approved"
      t.integer :approved_id, comment: "the id of the record that is being updated"      
    end
  end
end
