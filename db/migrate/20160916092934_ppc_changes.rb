class PpcChanges < ActiveRecord::Migration
  def up
    rename_table :pc_programs, :pc_products

    create_table :pc_programs, {:sequence_start_value => '1 cache 20 order increment by 1'}  do |t|
      t.string :code, :null => false, :limit => 15, :comment => "the code that identifies the program"
      t.string :is_enabled, :null => false, :limit => 1, :comment => "the flag to decide if the account is enabled or not"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"
      t.string :approval_status, :limit => 1, :default => 'U', :null => false, :comment => "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, :limit => 1, :default => 'C', :null => false, :comment => "the last action (create, update) that was performed on the record"
      t.integer :approved_version, :comment => "the version number of the record, at the time it was approved"
      t.integer :approved_id, :comment => "the id of the record that is being updated"
    end

    add_index :pc_programs, [:code, :approval_status], :unique => true, :name => "pc_programs_02"

    rename_column :pc_fee_rules, :program_code, :product_code

    add_column :pc_products, :card_acct, :string, :limit => 20, :comment =>  "the casa account for recording card transactions"
    add_column :pc_products, :sc_gl_income, :string, :limit => 15, :comment =>  "the gl account for recording fee income"
    add_column :pc_products, :card_cust_id, :string, :comment =>  'the customer id of the card'
    add_column :pc_products, :display_name, :string, :comment => 'the product name, displayed to customers'
    add_column :pc_products, :cust_care_no, :string, :limit => 16, :comment => 'the customer care no, displayed to customers'
    add_column :pc_products, :rkb_user, :string, :limit => 30, :comment => 'the user name to authenticate with rkb'
    add_column :pc_products, :rkb_password, :string, :comment => 'the password to authenticate with rkb'
    add_column :pc_products, :rkb_bcagent, :string, :limit => 50, :comment => 'the bcagent issued by rkb, used for authentication'
    add_column :pc_products, :rkb_channel_partner, :string, :limit => 3, :comment => 'the channel partner issued by rkb, used for authentication'
    add_column :pc_products, :program_code, :string, :limit => 15, :comment => 'the code of the pc program'

    add_column :pc_customers, :program_code, :string, :limit => 15, :comment => 'the code of the program'
    add_column :pc_customers, :product_code, :string, :limit => 15, :comment => 'the code of the product'

    add_column :pc_card_registrations, :program_code, :string, :limit => 15, :comment => 'the code of the program'
    add_column :pc_card_registrations, :product_code, :string, :limit => 15, :comment => 'the code of the product'

    PcApp.unscoped.find_each(batch_size: 100) do |app_record|
      if app_record.approval_status == 'U' 
        app_record.approved_record.nil? ? app = app_record : app = app_record.approved_record
      else
        app = app_record
      end
        
      products = PcProduct.unscoped.where("code=?",app.program_code)
      unless products.empty?
        products.update_all(:card_acct => app.card_acct, :sc_gl_income => app.sc_gl_income, :card_cust_id => app.card_cust_id,
                            :cust_care_no => '1234', :rkb_user => 'user', :rkb_password => EncPassGenerator.new('password', ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password,
                            :rkb_bcagent => 'agent', :rkb_channel_partner => '123') 
      end
      pc = PcProgram.unscoped.find_by_code(app.program_code)
      if pc.nil?
        p = PcProgram.create(:code => app.program_code, :is_enabled => 'Y')
        p.update_attribute(:approval_status,'A')
      end
    end

    products = PcProduct.unscoped.where("card_acct is null").delete_all

    PcProduct.unscoped.find_each(batch_size: 100) do |p|
      p.update_attribute(:program_code, p.code)
    end

    PcCustomer.find_each(batch_size: 100) do |cust|
      cust.program_code = cust.app.try(:program_code)
      cust.product_code = cust.app.try(:program_code)
      cust.save(:validate => false)
    end

    PcCustomer.where("program_code is null").delete_all

    PcCardRegistration.find_each(batch_size: 100) do |card|
      card.program_code = card.app.try(:program_code)
      card.product_code = card.app.try(:program_code)
      card.save(:validate => false)
    end

    change_column :pc_products, :card_acct, :string, :limit => 20, :null => false, :comment =>  "the casa account for recording card transactions"
    change_column :pc_products, :sc_gl_income, :string, :limit => 15, :null => false, :comment =>  "the gl account for recording fee income"
    change_column :pc_products, :card_cust_id, :string, :null => false, :comment =>  'the customer id of the card'
    change_column :pc_products, :cust_care_no, :string, :null => false, :limit => 16, :comment => 'the customer care no, displayed to customers'
    change_column :pc_products, :rkb_user, :string, :limit => 30, :null => false, :comment => 'the user name to authenticate with rkb'
    change_column :pc_products, :rkb_password, :string, :limit => 40, :null => false, :comment => 'the password to authenticate with rkb'
    change_column :pc_products, :rkb_bcagent, :string, :limit => 50, :null => false, :comment => 'the bcagent issued by rkb, used for authentication'
    change_column :pc_products, :rkb_channel_partner, :string, :null => false, :limit => 3, :comment => 'the channel partner issued by rkb, used for authentication'
    change_column :pc_products, :program_code, :string, :limit => 15, :null => false, :comment => 'the code of the pc program'

    change_column :pc_customers, :program_code, :string, :limit => 15, :null => false, :comment => 'the code of the program'
    change_column :pc_customers, :product_code, :string, :limit => 15, :null => false, :comment => 'the code of the product'

    remove_index :pc_customers, :name => 'uk_pc_card_custs_1'
    add_index :pc_customers, [:mobile_no, :program_code], :name => 'pc_customers_01', unique: true
    add_index :pc_customers, [:email_id, :program_code], :name => 'pc_customers_02', unique: true

    remove_column :pc_apps, :card_acct
    remove_column :pc_apps, :sc_gl_income
    remove_column :pc_apps, :card_cust_id
    remove_column :pc_apps, :traceid_prefix
    remove_column :pc_apps, :source_id
    remove_column :pc_apps, :channel_id
  end

  def down
    add_column :pc_apps, :card_acct, :string, :limit => 20, :comment =>  "the casa account for recording card transactions"
    add_column :pc_apps, :sc_gl_income, :string, :limit => 15, :comment =>  "the gl account for recording fee income"
    add_column :pc_apps, :card_cust_id, :string, :comment => 'the customer id of the card'
    add_column :pc_apps, :traceid_prefix, :integer, :comment => 'the trace id'
    add_column :pc_apps, :source_id, :string, :limit => 50, :comment => 'the source id'
    add_column :pc_apps, :channel_id, :string, :limit => 20, :comment => 'the channel id'
    
    PcProduct.unscoped.find_each(batch_size: 100) do |p|
      apps = PcApp.unscoped.where("program_code=?",p.code)
      unless apps.empty?
        apps.update_all(:card_acct => p.card_acct, :sc_gl_income => p.sc_gl_income,
                        :card_cust_id => p.card_cust_id, :traceid_prefix => 1234, :source_id => '1234',
                        :channel_id => '1234') 
      end
    end

    change_column :pc_apps, :card_acct, :string, :limit => 20, :null => false, :comment =>  "the casa account for recording card transactions"
    change_column :pc_apps, :sc_gl_income, :string, :limit => 15, :null => false, :comment =>  "the gl account for recording fee income"
    change_column :pc_apps, :card_cust_id, :string, :null => false, :comment => 'the customer id of the card'
    change_column :pc_apps, :traceid_prefix, :integer, :null => false, :comment => 'the trace id'
    change_column :pc_apps, :source_id, :string, :limit => 50, :null => false, :comment => 'the source id'
    change_column :pc_apps, :channel_id, :string, :limit => 20, :null => false, :comment => 'the channel id'

    rename_column :pc_fee_rules, :product_code, :program_code

    remove_column :pc_products, :card_acct
    remove_column :pc_products, :sc_gl_income
    remove_column :pc_products, :card_cust_id
    remove_column :pc_products, :display_name
    remove_column :pc_products, :cust_care_no
    remove_column :pc_products, :rkb_user
    remove_column :pc_products, :rkb_password
    remove_column :pc_products, :rkb_bcagent
    remove_column :pc_products, :rkb_channel_partner
    remove_column :pc_products, :program_code
    remove_column :pc_customers, :program_code
    remove_column :pc_customers, :product_code
    remove_column :pc_card_registrations, :program_code
    remove_column :pc_card_registrations, :product_code

    remove_index :pc_customers, :name => 'pc_customers_01'
    remove_index :pc_customers, :name => 'pc_customers_02'
    add_index :pc_customers, [:mobile_no], :name => 'uk_pc_card_custs_1', :unique => true

    drop_table :pc_programs
    rename_table :pc_products, :pc_programs
  end
end
