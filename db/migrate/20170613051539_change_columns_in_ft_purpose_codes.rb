class ChangeColumnsInFtPurposeCodes < ActiveRecord::Migration
  def change
    add_column :ft_purpose_codes, :is_frozen, :string, limit: 1, null: false, default: 'N', comment: 'the flag which ensures the values other than is_enabled is not changed by users'
    rename_column :ft_purpose_codes, :allowed_transfer_type, :allowed_transfer_types
    FtPurposeCode.unscoped.update_all(allowed_transfer_types: ['IMPS', 'NEFT', 'RTGS'])
    change_column :ft_purpose_codes, :allowed_transfer_types, :string, default: 'IMPS,NEFT,RTGS'
    add_column :ft_purpose_codes, :setting1, :string, comment: 'the setting 1 for the purpose_code'
    add_column :ft_purpose_codes, :setting2, :string, comment: 'the setting 2 for the purpose_code'
    add_column :ft_purpose_codes, :setting3, :string, comment: 'the setting 3 for the purpose_code'
    add_column :ft_purpose_codes, :setting4, :string, comment: 'the setting 4 for the purpose_code'
    add_column :ft_purpose_codes, :setting5, :string, comment: 'the setting 5 for the purpose_code'
    add_column :ft_purpose_codes, :settings_cnt, :integer, null: false, default: 0, comment: 'the count of settings for the purpose_code'
  end
end
