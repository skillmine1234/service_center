class ChangeColumnRefTxnNoInQgEcolTodaysNeftTxns < ActiveRecord::Migration[7.0]
  def change
    unless Rails.env == 'production'
      def self.connection
       QgEcolTodaysNeftTxn.connection
      end
      change_column :qg_ecol_todays_neft_txns, :ref_txn_no, :string, :limit => 15, :null => true
    end
  end
end
