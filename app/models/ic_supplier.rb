class IcSupplier < ActiveRecord::Base
  include Approval
  include IcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :supplier_code, :supplier_name, :customer_id, :od_account_no, :ca_account_no

  validates_numericality_of :customer_id, :od_account_no, :ca_account_no

  validates_uniqueness_of :supplier_code, :scope => [:customer_id, :approval_status]

  [:supplier_code, :customer_id].each do |column|
    validates column, length: { maximum: 15 }
  end
  [:od_account_no, :ca_account_no].each do |column|
    validates column, length: { maximum: 20 }
  end
  validates :supplier_name, length: { maximum: 100 }

  validates :supplier_code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }
  validates :supplier_name, format: {with: /\A[a-z|A-Z|0-9\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9-.\s]}' }
                                           
  before_save :to_upcase

  def to_upcase
    unless self.frozen?
      self.supplier_name = self.supplier_name.upcase unless self.supplier_name.nil?
    end
  end

end
