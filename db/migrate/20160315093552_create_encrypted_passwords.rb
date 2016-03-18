class CreateEncryptedPasswords < ActiveRecord::Migration
  def change
    create_table :encrypted_passwords do |t|
      t.integer :created_by
      t.string :password

      t.timestamps null: false
    end
  end
end
