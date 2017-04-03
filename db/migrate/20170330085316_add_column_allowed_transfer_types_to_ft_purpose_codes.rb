class AddColumnAllowedTransferTypesToFtPurposeCodes < ActiveRecord::Migration
  def change
    add_column :ft_purpose_codes, :allowed_transfer_type, :string, :limit => 50, default: 'ANY', :comment => "The allowed tranfer types for the purpose Code"    
  end
end
