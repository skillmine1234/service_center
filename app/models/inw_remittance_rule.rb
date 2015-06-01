class InwRemittanceRule < ActiveRecord::Base
  audited
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  before_validation :format_fields
  validate :validate_keywords

  def validate_keywords
    ["pattern_individuals","pattern_corporates", "pattern_beneficiaries","pattern_remitters","pattern_salutations"].each do |values|
      invalid_values = []
      value = self.send(values)
      unless value.nil?
        value.split(/,/).each do |val| 
          unless val =~ /\A[A-Za-z0-9\-\(\)\s]+\Z/
            invalid_values << val
          end
        end
      end
      errors.add(values.to_sym, "are invalid due to #{invalid_values.join(',')}") unless invalid_values.empty?
    end
  end

  def format_fields
    self.pattern_individuals = self.pattern_individuals.gsub("\r\n",",") rescue nil
    self.pattern_corporates = self.pattern_corporates.gsub("\r\n",",") rescue nil
    self.pattern_beneficiaries = self.pattern_beneficiaries.gsub("\r\n",",") rescue nil
    self.pattern_remitters = self.pattern_remitters.gsub("\r\n",",") rescue nil
    self.pattern_salutations = self.pattern_salutations.gsub("\r\n",",") rescue nil
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

  def formated_pattern_remitters
    pattern_remitters.gsub(",","\r\n") rescue nil
  end  

  def formated_pattern_salutations
    pattern_salutations.gsub(",","\r\n") rescue nil
  end  
end