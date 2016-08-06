class AddProgramCodeTpPcFeeRules < ActiveRecord::Migration
  def change
    add_column :pc_fee_rules, :program_code, :string, :limit => 15, :comment => "the code that identifies the program"
    db.execute "UPDATE pc_fee_rules SET program_code = 'A'"
    change_column :pc_fee_rules, :program_code, :string, :limit => 15, :null => false, :comment => "the code that identifies the program"

    PcFeeRule.find_each(batch_size: 100) do |fee|
      fee.program_code = 'P' + fee.app_id.to_s
      fee.save
    end
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
