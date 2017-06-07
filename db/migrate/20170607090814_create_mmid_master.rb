class CreateMmidMaster < ActiveRecord::Migration
  def up
    unless Rails.env == 'production'
      def self.connection
        Atom::Customer.connection
      end
      create_table :mmid_master, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
        t.string :accountno, limit: 25, null: false
        t.string :mobileno, limit: 10, null: false
        t.string :mmid, limit: 20, null: false
        t.string :customerid, limit: 20
        t.string :cbsno, limit: 20
        t.date :creationdate
        t.string :isactive, limit: 2
        t.string :created_by, limit: 30
        t.datetime :rodt
      end
    end
  end
  
  def down
    unless Rails.env == 'production'
      def self.connection
        Atom::Customer.connection
      end
      drop_table :mmid_master
    end
  end
end
