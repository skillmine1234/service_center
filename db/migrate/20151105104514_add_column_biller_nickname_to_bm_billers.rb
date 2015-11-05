class AddColumnBillerNicknameToBmBillers < ActiveRecord::Migration
  def change
    add_column :bm_billers, :biller_nickname, :string, :limit => 10
  end
end
