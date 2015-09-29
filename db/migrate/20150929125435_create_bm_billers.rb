class CreateBmBillers < ActiveRecord::Migration
  def change
    create_table :bm_billers do |t|
      t.string :biller_code, :limit => 100, :null => false, :comment => 'the unique code that identifies a biller, this is unique across billers'
      t.string :biller_name, :limit => 100, :null => false, :comment => 'the name of the biller'
      t.string :biller_category, :limit => 100, :null => false, :comment => 'the category assigned to the biller'
      t.string :biller_location, :limit => 100, :null => false, :comment => 'the location in which the biller is active'
      t.string :processing_method, :limit => 100, :null => false, :comment => 'the method used to to process the bill, only presentment, only payee or both.'
      t.string :is_enabled, :limit => 1, :null => false, :comment => 'the indicator that can be used to disable a biller, without deleting it.'
      t.integer :num_params, :null => false, :comment => 'the number of parameters the biller needs to identify the bill/subscriber'
      t.string :param1_name, :limit => 100, :comment => 'the name of the parameter'
      t.string :param1_pattern, :limit => 100, :comment => 'the regular expression to verify the validate the value of the parameter'
      t.string :param1_tooltip, :limit => 100, :comment => 'the description of the parameter'
      t.string :param2_name, :limit => 100, :comment => 'the name of the parameter'
      t.string :param2_pattern, :limit => 100, :comment => 'the regular expression to verify the validate the value of the parameter'
      t.string :param2_tooltip, :limit => 100, :comment => 'the description of the parameter'
      t.string :param3_name, :limit => 100, :comment => 'the name of the parameter'
      t.string :param3_pattern, :limit => 100, :comment => 'the regular expression to verify the validate the value of the parameter'
      t.string :param3_tooltip, :limit => 100, :comment => 'the description of the parameter'
      t.string :param4_name, :limit => 100, :comment => 'the name of the parameter'
      t.string :param4_pattern, :limit => 100, :comment => 'the regular expression to verify the validate the value of the parameter'
      t.string :param4_tooltip, :limit => 100, :comment => 'the description of the parameter'
      t.string :param5_name, :limit => 100, :comment => 'the name of the parameter'
      t.string :param5_pattern, :limit => 100, :comment => 'the regular expression to verify the validate the value of the parameter'
      t.string :param5_tooltip, :limit => 100, :comment => 'the description of the parameter'
      t.integer :lock_version, :null => false, :comment => 'the version number of the record, every update increments this by 1.'
      t.datetime :created_at, :null => false, :comment => 'the timestamp when the record was created'
      t.datetime :updated_at, :null => false, :comment => 'the timestamp when the record was last updated'
      t.string :approval_status, :limit => 1, :null => false, :comment => 'the indicator to denote whether this record is pending approval or is approved'
      t.string :last_action, :limit => 1, :comment => 'the last action (create, update) that was performed on the record.'
      t.integer :approved_version, :comment => 'the version number of the record, at the time it was approved'
      t.integer :approved_id, :comment => 'the id of the record that is being updated'               
    end

    add_index :bm_billers, :biller_code, :unique => true
  end
end
