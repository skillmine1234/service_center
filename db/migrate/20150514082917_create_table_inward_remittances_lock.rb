class CreateTableInwardRemittancesLock < ActiveRecord::Migration
  def change
    create_table :inward_remittances_locks do |t|
      t.string :partner_code
      t.string :req_no
    end
  end
end
