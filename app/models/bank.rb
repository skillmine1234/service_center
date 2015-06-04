class Bank < ActiveRecord::Base
  audited
  validates_presence_of :ifsc, :name
  validates :ifsc, format: {with: /\A[A-Z|a-z]{4}[0][A-Za-z0-9]{6}+\z/, :allow_blank => true }

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  def imps_enabled?
    imps_enabled ? 'Y' : 'N'
  end
end
