class CreateBmRules < ActiveRecord::Migration[7.0]
  def change
    create_table :bm_rules do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :cod_acct_no, :limit => 16, :null => false, :comment => 'the pool account assigned to the aggregator, the balance is owed to the aggregator'
      t.string :customer_id, :limit => 15, :null => false, :comment => 'the customer-id that owns the pool account'
      t.string :cod_gl_suspense, :limit => 16, :null => false, :comment => 'the suspense gl assigned to the aggregator, the balance is pending reconciliation'
      t.string :bene_acct_no, :null => false, :comment => 'the aggregators account no, funds are remitted to this account'
      t.string :bene_account_ifsc, :null => false, :comment => 'the IFSC code of the bank that holds the aggregators account.'
      t.string :neft_sender_ifsc, :null => false, :comment => 'the IFSC code of your bank, that should be used while remitting funds to the aggregator'
      t.integer :lock_version, :null => false, :comment => 'the version number of the record, every update increments this by 1.'
      t.datetime :created_at, :null => false, :comment => 'the timestamp when the record was created'
      t.datetime :updated_at, :null => false, :comment => 'the timestamp when the record was last updated'
      t.string :approval_status, :limit => 1, :null => false, :comment => 'the indicator to denote whether this record is pending approval or is approved'
      t.string :last_action, :limit => 1, :comment => 'the last action (create, update) that was performed on the record.'
      t.integer :approved_version, :comment => 'the version number of the record, at the time it was approved'
      t.integer :approved_id, :comment => 'the id of the record that is being updated'               
    end
  end
end
