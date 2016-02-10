class CreateBmAggregatorPayments < ActiveRecord::Migration
  def change
    create_table :bm_aggregator_payments do |t|
      t.string :cod_acct_no, :limit => 50, :null => false, :comment => 'the pool account assigned to the aggregator, the balance is owed to the aggregator'
      t.string :neft_sender_ifsc, :null => false, :comment => 'the IFSC code of your bank, that should be used while remitting funds to the aggregator'
      t.string :bene_acct_no, :limit => 50, :null => false, :comment => 'the aggregators account no, funds are remitted to this account'
      t.string :bene_account_ifsc, :null => false, :comment => 'the IFSC code of the bank that holds the aggregators account.'
      t.number :payment_amount, :comment => 'the amount paid to the aggregator'
      t.string :bank_ref, :limit => 64, :comment => 'the reference number for the payment, also called UTR/RRN'
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
