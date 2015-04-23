class PurposeCode < ActiveRecord::Base
  audited
  attr_accessible :code, :created_by, :daily_txn_limit, :description, :disallowed_bene_types, 
                  :disallowed_rem_types, :is_enabled, :lock_version, :txn_limit, :updated_by

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :code, :description, :is_enabled, :txn_limit, :daily_txn_limit

end
