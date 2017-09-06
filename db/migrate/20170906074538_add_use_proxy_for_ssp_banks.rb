class AddUseProxyForSspBanks < ActiveRecord::Migration
  def change
    remove_column :ssp_banks, :user_proxy
    add_column :ssp_banks, :use_proxy, :string, limit: 1, :null => false, :default => 'Y', comment: 'the identifier to tell if proxy has to be used for this customer'
  end
end
