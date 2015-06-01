class CreateInwCbsResponseCodes < ActiveRecord::Migration
  def change
    create_table :inw_cbs_response_codes do |t|
      t.string :cbs_name
      t.string :function_name
      t.string :response_code
      t.string :consider_as
      t.string :created_by
      t.string :updated_by

      t.timestamps null: false
    end
  end
end
