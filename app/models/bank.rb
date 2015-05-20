class Bank < ActiveRecord::Base
  audited
  validates_presence_of :ifsc, :name, :imps_enabled
  validates :ifsc, format: {with: /\A[A-Z|a-z]{4}[0][A-Za-z0-9]{6}+\z/ }

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
end
