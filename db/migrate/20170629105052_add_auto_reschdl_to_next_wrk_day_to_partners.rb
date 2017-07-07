class AddAutoReschdlToNextWrkDayToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :auto_reschdl_to_next_wrk_day, :string, :limit => 1, :default => "Y", :comment => "the indetifier to specify if the transaction has to be rescheduled for the next working day intead of failing it."  
  end
end
