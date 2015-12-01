class ChangeDefaultValueOfBeneName < ActiveRecord::Migration
  def change
    change_column :bm_aggregator_payments, :rmtr_name, :string, :limit => 50, :null => false, :default => '', :comment => "the full name of the sender"
  end
end
