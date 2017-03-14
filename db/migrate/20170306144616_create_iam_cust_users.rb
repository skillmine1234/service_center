class CreateIamCustUsers < ActiveRecord::Migration
  def change
    create_table :iam_cust_users, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :username, limit: 100, null: false, comment: 'the username in the LDAP, this is unique across customers'
      t.string :first_name, comment: 'the first name of the individual to whom the username is assigned'
      t.string :last_name, limit: 100, comment: 'the last name of the individual to whom the username is assigned'
      t.string :email, limit: 100, comment: 'the email address of the individual to whom the username is assigned, the password is sent to this email'
      t.string :mobile_no, limit: 10, comment: 'the mobile no of the individual to whom the username is assigned, the password is sent to this number'
      t.string :encrypted_password, comment: 'the encrypted password that was set or generated for the user'
      t.string :should_reset_password, limit: 1, comment: 'the indicator that specifies whether a password reset is being initiated'
      t.string :was_user_added, limit: 1, comment: 'the indicator that specifies whether this user was successfully added to ldap or not'
      t.datetime :last_password_reset_at, comment: 'the last time the password was reset for this user'
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"
      
      t.string :last_action, limit: 1, default: 'C', null: false, comment: "the last action (create, update) that was performed on the record"
      t.string :approval_status, limit: 1, default: 'U', null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
      t.integer :approved_version, comment: "the version number of the record, at the time it was approved"
      t.integer :approved_id, comment: "the id of the record that is being updated"

      t.index([:username, :approval_status], :unique => true, name: 'iam_cust_users_01')
    end
  end
end
