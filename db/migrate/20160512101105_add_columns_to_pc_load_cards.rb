class AddColumnsToPcLoadCards < ActiveRecord::Migration
  def change
    add_column :pc_load_cards, :service_charge, :number, :comment => "the service charge applied for the transaction, exclusive of tax"
    add_column :pc_load_cards, :debit_fee_status, :string, :limit => 50, :comment => "the status of the debit fee step"
    add_column :pc_load_cards, :debit_fee_result, :string, :limit => 1000, :comment => "the reason for the debit fee step, if step is failed"
  end
end
