class CreateIamAuditRules < ActiveRecord::Migration
  def change
    create_table :iam_audit_rules , {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :org_uuid, null: false, limit: 1, :default => 'N', comment: 'the identifier to specify if org uuid failure has to be logged'
      t.string :cert_dn, null: false, limit: 1, :default => 'N', comment: 'the identifier to specify if certificate dn failure has to be logged'
      t.string :source_ip, null: false, limit: 1, :default => 'N', comment: 'the identifier to specify if ip address failure has to be logged'      
      t.integer :interval_in_mins, null: false, default: 15, comment: 'the log interval in mins till when the enabled failures will get logged'
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.integer :lock_version, null: false, default: 0, comment: 'the version number of the record, every update increments this by 1' 
    end
  end
end
