class AddColumnsCreditedAtToIcPaynows < ActiveRecord::Migration
  def change
    add_column :ic_paynows, :credited_at, :date, comment: 'the processed date of the transaction'             
  end
end