class PurposeCode < ActiveRecord::Base
  audited
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :description, :is_enabled, :txn_limit, :daily_txn_limit
  validates_uniqueness_of :code
  
  def self.options_for_bene_and_rem_types
    [['Individual','I'],['Non-Individual','N']]
  end
  
  def convert_disallowed_rem_types_to_array
    if (self.disallowed_rem_types.is_a? String)
      self.disallowed_rem_types=self.disallowed_rem_types.split(',')
    end
  end
  
  def convert_disallowed_bene_types_to_array
    if (self.disallowed_bene_types.is_a? String)
      self.disallowed_bene_types=self.disallowed_bene_types.split(',')
    end
  end
  
  def convert_disallowed_bene_types_to_string(value)
    if (value.is_a? Array)
      value.reject!(&:blank?)
      self.disallowed_bene_types=value.join(',')
    end
  end 
  
  def convert_disallowed_rem_types_to_string(value)
    if (value.is_a? Array)
      value.reject!(&:blank?)
      self.disallowed_rem_types=value.join(',')
    end
  end  
  
  def value_for_disallowed_bene_and_rem_types_on_show_page(value)
    if (value == "I,N")
      "Individual,Non-Individual"
    elsif (value == "I")
      "Individual"
    else
      "Non-Individual"
    end
  end

end
