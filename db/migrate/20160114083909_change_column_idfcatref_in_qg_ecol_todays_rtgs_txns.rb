class ChangeColumnIdfcatrefInQgEcolTodaysRtgsTxns < ActiveRecord::Migration
  def change
    unless Rails.env == 'production'
      def self.connection
       QgEcolTodaysRtgsTxn.connection
      end
      change_column :qg_ecol_todays_rtgs_txns, :idfcatref, :string, :limit => 16, :null => true
    end
  end
end
