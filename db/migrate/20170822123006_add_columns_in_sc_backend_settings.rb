class AddColumnsInScBackendSettings < ActiveRecord::Migration
  def change
    add_column :sc_backend_settings, :is_std, :string, limit: 1, default: 'N', null: false, comment: 'the flag which indicates whether the setting is std or not'
    add_column :sc_backend_settings, :is_enabled, :string, limit: 1, default: 'N', null: false, comment: 'the flag which indicates whether the setting is enabled or not'
  end
end
