class CreateFtCustomerDisableLists < ActiveRecord::Migration
  def change
    create_table :ft_customer_disable_lists do |t|
      t.string :app_id
      t.string :customer_id
      t.integer :user_id
      t.string :approval_status,:limit => 1, :default => 'U'
      t.integer :approved_version
      t.integer :approved_id
      t.string :last_action,:limit => 1, :default => 'C'

      t.timestamps null: false
    end
  end
end