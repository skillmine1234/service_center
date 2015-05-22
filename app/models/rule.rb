class Rule < ActiveRecord::Base
  audited
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  before_save :format_fields

  def format_fields
    self.pattern_individuals = self.pattern_individuals.gsub("\r\n",",") rescue nil
    self.pattern_corporates = self.pattern_corporates.gsub("\r\n",",") rescue nil
    self.pattern_beneficiaries = self.pattern_beneficiaries.gsub("\r\n",",") rescue nil
  end

  def formated_pattern_individuals
    pattern_individuals.gsub(",","\r\n") rescue nil
  end

  def formated_pattern_corporates
    pattern_corporates.gsub(",","\r\n") rescue nil
  end

  def formated_pattern_beneficiaries
    pattern_beneficiaries.gsub(",","\r\n") rescue nil
  end  
end