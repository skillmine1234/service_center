class CreateCiCustmast < ActiveRecord::Migration
  def up
    unless Rails.env == 'production'
      def self.connection
        Fcr::Customer.connection
      end
      create_table :ci_custmast, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
        t.integer :cod_cust_id, null: false
        t.string :nam_cust_full, limit: 120
        t.string :flg_cust_typ, limit: 1
        t.string :flg_mnt_status, limit: 1
        t.string :ref_cust_email, limit: 120
        t.string :ref_cust_telex, limit: 45
        t.string :nam_cust_first, limit: 60
        t.string :nam_cust_last, limit: 60
        t.date :dat_birth_cust
        t.string :txt_custadr_add1, limit: 105
        t.string :txt_custadr_add2, limit: 105
        t.string :txt_custadr_add3, limit: 105
        t.string :nam_custadr_city, limit: 105
        t.string :nam_custadr_state, limit: 105
        t.string :nam_custadr_cntry, limit: 105
        t.string :txt_custadr_zip, limit: 105
        t.string :txt_cust_sex, limit: 1
        t.string :ref_cust_it_num, limit: 100
        t.string :flg_staff, limit: 10
        t.date :dat_cust_open
        t.date :dat_incorporated
        t.string :ref_cust_phone, limit: 10
        t.string :cod_mis_cust_code_2, limit: 100
      end
    end
  end
  
  def down
    unless Rails.env == 'production'
      def self.connection
        Fcr::Customer.connection
      end
      drop_table :ci_custmast
    end
  end
end
