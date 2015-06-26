class UdfAttribute < ActiveRecord::Base
  audited except: [:approval_status, :last_action]
  attr_writer :length, :max_length, :min_length, :min_value, :max_value
  attr_reader :length, :max_length, :min_length, :min_value, :max_value

  has_one :ecol_unapproved_record, :as => :ecol_approvable

  CONTROL_TYPES = %w(TextBox DropDown CheckBox)
  DATA_TYPES = %w(String Numeric Date)
  TextValidators = {:length => ['number', 'is'], :min_length => ['number', 'minimum'], :max_length => ['number', 'maximum']}.freeze
  NumericValidators = {:min_value => ['number', 'minimum'], :max_value => ['number', 'maximum']}.freeze
  
  serialize :constraints
  serialize :select_options
  
  before_save :construct_validate_hash
  after_initialize :regenerate_accessor_fields, if: Proc.new { |tf| tf.constraints.present? }
  
  validate :validate_options
  validates_presence_of :class_name, :attribute_name, :is_enabled
  validate :validate_data_type
  validate :validate_constraint_input
  validate :cross_field_validations
  validates_uniqueness_of :attribute_name, :scope => [:class_name,:approval_status]

  after_save :create_ecol_unapproved_records
  
  def self.default_scope
    where approval_status: 'A'
  end

  def create_ecol_unapproved_records
    if approval_status == 'U' and ecol_unapproved_record.nil?
      EcolUnapprovedRecord.create!(:ecol_approvable => self, :unique_value => attribute_name)
    end
  end

  def validate_constraint_input
    if self.data_type == "String" and !self.length.to_s.empty? and (!self.min_length.to_s.empty? or !self.max_length.to_s.empty?)
      errors.add(:data_type, "Please specify Either Length or (min Length and max Length) for this data type")
    end
  end

  def validate_data_type
    if control_type == "TextBox" and data_type.to_s.empty?
      errors.add(:data_type, "should be present for TextBox control") 
    end
  end

  def validate_options
    if !select_options.to_s.empty? and control_type == "DropDown"
      valid_flag = YAML.load(select_options).to_a rescue false
      errors.add(:select_options,"not in the following format <br> \"name1\": \"value1\" <br> \"name2\": \"value2\" <br>") if valid_flag == false or check_syntax_for_select_options == false
    elsif select_options.to_s.empty? and control_type == "DropDown"
      errors.add(:select_options,"can't be empty when control type is DropDown")
    end
  end
    
  def select_options_list
    if select_options.to_s.empty? 
      nil
    else
      YAML.load(select_options) rescue nil 
    end
  end

  def check_syntax_for_select_options
    values = select_options.to_s.split("\n")
    values.each do |v|
      key_value = v.split(":")
      unless key_value.empty?
      key_value.each do |kv|
          return false if (/\A"/).match(kv.strip).nil? or (/"\Z/).match(kv.strip).nil?
        end
      end
    end
  end

  def type
    if control_type == "CheckBox"
      "boolean"
    elsif control_type == "DropDown"
      "select"
    elsif control_type == "TextBox"
      data_type == "Date" ? "date" : "string"
    end
  end
    
  def regenerate_accessor_fields
    constraints.each do |k,v|
      v.is_a?(Hash) ? self.send("#{k.to_s}=",v[v.keys.first]) : self.send("#{k.to_s}=", v)
    end
    self.format = "/"+self.format.source+"/" if self.format rescue ""
  end

  def construct_validate_hash
    hash = {}
    validators = TextValidators.merge(NumericValidators)
    validators.each do |k,v|
      value = self.send(k)
      if value.present?
        value = value.is_a?(String) ? eval(value) : value
        if v.length > 1
          hash[k] = {v.last.to_sym => value}
          hash[k].merge!(:message => "should be of #{value} characters") if k == :length
        elsif !value.zero?
          hash[k] = value
        end
      end
    end
    self.constraints = hash
  end
  
    
  def cross_field_validations
    errors.add(:label_text, "Label_text is mandatory if is_enabled is Y") if (self.is_enabled == 'Y' && self.label_text.blank?)       
    errors.add(:control_type, "Control_type is mandatory if is_enabled is Y") if (self.is_enabled == 'Y' && self.control_type.blank?)      
    errors.add(:control_type, "Constraints cannot be entered if control_type is Dropdown") if (self.control_type ==  "DropDown" && (!self.max_length.blank? || !self.min_length.blank?))
  end
    
  def self.options_for_attribute_name
    [['udf1','udf1'],['udf2','udf2'],['udf3','udf3'],['udf4','udf4'],['udf5','udf5'],['udf6','udf6'],['udf7','udf7'],['udf8','udf8'],
    ['udf9','udf9'],['udf10','udf10'],['udf11','udf11'],['udf12','udf12'],['udf13','udf13'],['udf14','udf14'],['udf15','udf15'],['udf16','udf16'],
    ['udf17','udf17'],['udf18','udf18'],['udf19','udf19'],['udf20','udf20']]      
  end  
end
