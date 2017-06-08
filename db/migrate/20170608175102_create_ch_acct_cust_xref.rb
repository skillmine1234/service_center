class CreateChAcctCustXref < ActiveRecord::Migration
  def up
    unless Rails.env == 'production'
      def self.connection
        Fcr::CustomerAccount.connection
      end
      create_table :ch_acct_cust_xref, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
        t.integer :cod_cust
        t.string :cod_acct_cust_rel, limit: 9
        t.string :cod_acct_no, limit: 16, null: false
      end
    end
  end
  
  def down
    unless Rails.env == 'production'
      def self.connection
        Fcr::CustomerAccount.connection
      end
      drop_table :ch_acct_cust_xref
    end
  end

end
