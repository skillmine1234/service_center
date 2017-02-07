class InwGuideline < ActiveRecord::Base
  include Approval
  include InwApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_uniqueness_of :code, scope: :approval_status
  validates_presence_of :code, :allow_neft, :allow_imps, :allow_rtgs
  validates_numericality_of :ytd_txn_cnt_bene
  
  validates_format_of :disallowed_products, :with => /\A\w[\w\-\(\)\s\r\n]*\z/, :allow_blank => true
  before_validation :squish_disallowed_products


  def squish_disallowed_products
    unless self.frozen?
      self.disallowed_products = disallowed_products.squeeze(' ').strip.each_line.reject{|x| x.strip == ''}.join unless disallowed_products.nil?
    end
  end
end
