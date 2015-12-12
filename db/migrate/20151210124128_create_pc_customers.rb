class CreatePcCustomers < ActiveRecord::Migration
  def change
    create_table :pc_customers do |t|
      t.string :mobile_no, :null => false, :limit => 255, :comment => "the mobile no of the customer"
      t.string :title, :limit => 15, :comment => "the title of the customer"
      t.string :first_name, :limit => 255, :comment => "the first name of the customer"
      t.string :last_name, :limit => 255, :comment => "the last name of the customer"
      t.string :pref_name, :limit => 255, :comment => "the preferred name of the customer"
      t.string :email_id, :limit => 255, :comment => "the email id of the customer"
      t.string :password, :limit => 255, :comment => "the password of the customer"
      t.string :cust_status, :limit => 255, :comment => "the status of the customer"
      t.string :cust_uid, :limit => 255, :comment => "the unique no of the customer"
      t.date :birth_date, :comment => "the birth date of the customer"
      t.string :nationality, :limit => 255, :comment => "the nationality of the customer"
      t.integer :country_code, :comment => "the code of country where mobile no belongs to"
      t.date :reg_date, :comment => "the registration date of the customer"
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
      t.string :proxy_card_no, :null => false, :limit => 255, :comment => "the proxy no of the card issued to the customer"
      t.string :card_uid, :null => false, :limit => 255, :comment => "the unique id of the card "
      t.string :card_no, :null => false, :limit => 255, :comment => "the unique no of the card"
      t.string :card_type, :limit => 255, :comment => "the type of the card"
      t.string :card_name, :limit => 255, :comment => "the name of the card"
      t.string :card_desc, :limit => 255, :comment => "the description of the card"
      t.string :card_status, :limit => 255, :comment => "the status of the card"
      t.date :card_issue_date, :comment => "the issue date of the card"
      t.integer :card_expiry_year, :comment => "the expiry year of the card"
      t.integer :card_expiry_month, :comment => "the expiry month of the card"
      t.string :card_currency_code, :limit => 255, :comment => "the currency code of the card amount"
      t.decimal :available_funds, :comment => "the available funds in card"
      t.index([:mobile_no], :unique => true, :name => 'uk_pc_card_custs_1')
      t.index([:proxy_card_no], :unique => true, :name => 'uk_pc_card_custs_2')
      t.index([:card_uid], :unique => true, :name => 'uk_pc_card_custs_3')
      t.index([:card_no], :unique => true, :name => 'uk_pc_card_custs_4')
    end
  end
end
