class CreateSalaryRules < ActiveRecord::Migration
  def change
    create_table :salary_rules do |t|
     t.string :bank_pool_account_no, :null => false, :limit => 15, :comment => "the Bank Pool Acocunt No"
     t.string :threshold_percentage, :null => false, :comment => "the threshold % for matching names"      
    end
  end
end