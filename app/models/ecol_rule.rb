class EcolRule < ActiveRecord::Base
  audited
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :ifsc, :cod_acct_no, :stl_gl_inward, :stl_gl_return
  validates :ifsc, format: {with: /\A[A-Z]{4}[0][A-Z|0-9]{6}+\z/}
  validates :cod_acct_no, format: {with: /\A[a-z|A-Z|0-9]{1,15}+\z/}
  validates :stl_gl_inward, format: {with: /\A[a-z|A-Z|0-9]{1,15}+\z/}
  validates :stl_gl_return, format: {with: /\A[a-z|A-Z|0-9]{1,15}+\z/}
end
