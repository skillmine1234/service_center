class CreatePcRegistrations < ActiveRecord::Migration
  def change
    create_table :pc_card_registrations do |t|
      t.string :req_no, :limit => 32, :null => false, :comment =>  "the unique request number sent by the client"
      t.string :app_id, :limit => 32, :null => false, :comment => "the identifier for the client"
      t.integer :attempt_no, :null => false, :comment => "the attempt number of the request, failed requests can be retried"
      t.string :status_code, :limit => 25, :null => false, :comment => "the status of this request"
      t.string :req_version, :limit => 5, :null => false, :comment => "the service version number received in the request"
      t.datetime :req_timestamp, :comment => "the SYSDATE when the request was sent to the service provider"
      t.string :title, :limit => 15, :comment => "the title of the customer"
      t.string :first_name, :limit => 255, :comment => "the first name of the customer"
      t.string :last_name, :limit => 255, :comment => "the last name of the customer"
      t.string :pref_name, :limit => 255, :comment => "the preferred name of the customer"
      t.string :email_id, :limit => 255, :comment => "the email id of the customer"
      t.date :birth_date, :comment => "the birth date of the customer"
      t.string :nationality, :limit => 255, :comment => "the nationality of the customer"
      t.integer :country_code, :comment => "the code of country where mobile no belongs to"
      t.string :mobile_no, :limit => 255, :comment => "the mobile no of the customer"
      t.string :gender, :limit => 255, :comment => "the gender of the customer"
      t.string :doc_type, :limit => 255, :comment => "the type of the document"
      t.string :doc_no, :limit => 255, :comment => "the unique no of the document"
      t.string :country_of_issue, :limit => 255, :comment => "the name of country where documents belongs to"
      t.string :address_line1, :limit => 255, :comment => "the address line 1 of the customer"
      t.string :address_line2, :limit => 255, :comment => "the address line 2 of the customer"
      t.string :city, :limit => 255, :comment => "the city name of the customer"
      t.string :state, :limit => 255, :comment => "the state name of the customer"
      t.string :country, :limit => 255, :comment => "the country name of the customer"
      t.string :postal_code, :limit => 15, :comment => "the postal code of the city"
      t.string :proxy_card_no, :limit => 255, :comment => "the proxy no of the card issued to the customer"
      t.integer :pc_customer_id, :comment => "the foreign key to the pc_customers table"
      t.string :rep_no, :limit => 32, :comment => "the unique response number sent back by the API"
      t.string :rep_version, :limit => 5, :comment => "the service version sent in the reply"
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"
      t.string :fault_code, :limit => 255, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception "
      t.index([:req_no, :app_id, :attempt_no], :unique => true, :name => 'uk_pc_card_regs')
    end
  end  
end
