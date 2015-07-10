class EcolRule < ActiveRecord::Base
  include Approval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :ifsc, :cod_acct_no, :stl_gl_inward, :stl_gl_return, :neft_sender_ifsc, :cbs_userid
  validates :ifsc, :neft_sender_ifsc, format: {with: /\A[A-Z]{4}[0][A-Z|0-9]{6}+\z/, :message => "Invalid format, expected format is : {[A-Z]{4}[0][A-Z|0-9]{6}}" }
  validates :cod_acct_no, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }, length: {maximum: 15, minimum: 1}
  validates :stl_gl_inward, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }, length: {maximum: 15, minimum: 1}
  validates :stl_gl_return, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }, length: {maximum: 15, minimum: 1}
  validates :cbs_userid, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }, length: {maximum: 50, minimum: 1}
end
