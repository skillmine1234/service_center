class CreateTableInwardRemittancesLock < ActiveRecord::Migration
  def change
    create_table :inward_remittances_locks, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :partner_code
      t.string :req_no
    end
  end
end
