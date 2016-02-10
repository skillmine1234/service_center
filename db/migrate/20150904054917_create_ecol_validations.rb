class CreateEcolValidations < ActiveRecord::Migration
  def change
    create_table :ecol_validations, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :ecol_transaction_id
      t.integer :ecol_customer_id
      t.string :status_code, :limit => 10
      t.text :req_bitstream
      t.text :rep_bitstream
      t.datetime :req_timestamp, :datetime
      t.datetime :rep_timestamp, :datetime
      t.string :fault_code, :string
      t.string :fault_reason, :string
    end
  end
end
