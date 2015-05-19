class PurposeCode < ActiveRecord::Base
  audited
  before_save :disallowed_bene_toString, :disallowed_rem_toString  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :description, :is_enabled, :txn_limit, :daily_txn_limit
  
  def self.options_for_bene_and_rem_types
    [['Individual','I'],['Non-Individual','N']]
  end
  
  def disallowed_bene_toString
    if (self.disallowed_bene_types.is_a? Array)
      self.disallowed_bene_types.reject!(&:blank?)
      self.disallowed_bene_types=disallowed_bene_types.join(',')
    end
  end 
  
  def disallowed_rem_toString
    if (self.disallowed_rem_types.is_a? Array)
      self.disallowed_rem_types.reject!(&:blank?)
      self.disallowed_rem_types=disallowed_rem_types.join(',')
    end
  end  

  validates_uniqueness_of :code
end
