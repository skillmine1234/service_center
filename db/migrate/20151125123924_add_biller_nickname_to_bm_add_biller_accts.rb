class AddBillerNicknameToBmAddBillerAccts < ActiveRecord::Migration
  def change
    add_column :bm_add_biller_accts, :biller_nickname, :string, :limit => 10
  end
end
