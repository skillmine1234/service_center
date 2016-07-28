class RemoveAppIdAndAddPcProgramIdToPcFeeRules < ActiveRecord::Migration
  def change
    remove_column :pc_fee_rules, :app_id
    add_column :pc_fee_rules, :pc_program_id, :integer, :comment => "the id of the pc_programs record associated with this transaction"
    db.execute "UPDATE pc_fee_rules SET pc_program_id = 0"
    change_column :pc_fee_rules, :pc_program_id, :integer, :null => false, :comment => "the id of the pc_programs record associated with this transaction"
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
