class CreateSalaryCorporates < ActiveRecord::Migration
  def change
    create_table :salary_corporates do |t|
      t.string :customer_id, :limit => 15, :comment => "the Customer id of the Corporate that is related to current file"
      t.string :customer_name, :limit => 100, :comment => "the name of the Corporate that is related to current file"
      t.string :account_no, :limit => 16, :comment => "the Pool Account no of the Corporate that is related to current file"
      t.string :contact_person, :limit => 100, :comment => "the Name of the Contact person of the Corporate that is related to current file"
      t.string :email_address, :limit => 100, :comment => "the Email address of the Corporate that is related to current file"      
      t.string :customer_mobile_no, :limit => 10, :comment => "the Mobile no of the Corporate that is related to current file" 
    end
  end
end