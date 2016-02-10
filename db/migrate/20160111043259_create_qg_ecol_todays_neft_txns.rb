class CreateQgEcolTodaysNeftTxns < ActiveRecord::Migration
  def up
    unless Rails.env == 'production'
      def self.connection
       QgEcolTodaysNeftTxn.connection
      end
      create_table :qg_ecol_todays_neft_txns, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
        t.string :ref_txn_no, :limit => 15, :null => false
        t.string :transfer_type, :limit => 4, :null => false
        t.string :transfer_status, :limit => 25, :null => false
        t.string :transfer_unique_no, :limit => 64, :null => false
        t.string :rmtr_ref, :limit => 64, :null => false
        t.string :bene_account_ifsc, :limit => 20, :null => false
        t.string :bene_account_no, :limit => 64, :null => false
        t.string :bene_account_type, :limit => 10
        t.string :rmtr_account_ifsc, :limit => 20, :null => false
        t.string :rmtr_account_no, :limit => 64, :null => false
        t.string :rmtr_account_type, :limit => 10
        t.integer :transfer_amt, :null => false
        t.string :transfer_ccy, :limit => 5, :null => false
        t.datetime :transfer_date, :null => false
        t.string :rmtr_to_bene_note, :limit => 255
        t.string :rmtr_full_name, :limit => 255 
        t.string :rmtr_address, :limit => 255
        t.string :bene_full_name, :limit => 255
      end
    end
  end
  
  def down
    unless Rails.env == 'production'
      def self.connection
        QgEcolTodaysNeftTxn.connection
      end
      drop_table :qg_ecol_todays_neft_txns
    end
  end
end
