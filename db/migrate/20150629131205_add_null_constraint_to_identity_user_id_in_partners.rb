class AddNullConstraintToIdentityUserIdInPartners < ActiveRecord::Migration[7.0]
  def change
   # change_column :partners, :identity_user_id, :string, :limit => 20, :null => false
  end
end
