class AddNullConstraintToIdentityUserIdInPartners < ActiveRecord::Migration
  def change
    change_column :partners, :identity_user_id, :string, :limit => 20, :null => false
  end
end
