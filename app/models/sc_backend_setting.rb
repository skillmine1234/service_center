class ScBackendSetting < ActiveRecord::Base
  include Approval2::ModelAdditions
  
  SETTING_TYPES = ['text','number','date']

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  attr_accessor :needs_app_code

  store :setting1, accessors: [:setting1_name, :setting1_type, :setting1_value], coder: JSON
  store :setting2, accessors: [:setting2_name, :setting2_type, :setting2_value], coder: JSON
  store :setting3, accessors: [:setting3_name, :setting3_type, :setting3_value], coder: JSON
  store :setting4, accessors: [:setting4_name, :setting4_type, :setting4_value], coder: JSON
  store :setting5, accessors: [:setting5_name, :setting5_type, :setting5_value], coder: JSON
  store :setting6, accessors: [:setting6_name, :setting6_type, :setting6_value], coder: JSON
  store :setting7, accessors: [:setting7_name, :setting7_type, :setting7_value], coder: JSON
  store :setting8, accessors: [:setting8_name, :setting8_type, :setting8_value], coder: JSON
  store :setting9, accessors: [:setting9_name, :setting9_type, :setting9_value], coder: JSON
  store :setting10, accessors: [:setting10_name, :setting10_type, :setting10_value], coder: JSON
  
  validates_presence_of :backend_code, :service_code

  validates_presence_of :app_id, on: :create, if: "(approved_record.nil?) || (approved_record.app_id.present?)"
  validates_presence_of :app_id, on: :update, unless: "app_id_was.blank?"

  validates_uniqueness_of :backend_code, :scope => [:service_code, :app_id, :approval_status]
  
  validates :backend_code, :service_code, format: {with: /\A[a-z|A-Z|0-9|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\.|\-]}' }, length: { maximum: 50 }
  validates :app_id, format: {with: /\A[a-z|A-Z|0-9|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\.|\-]}' }, length: { maximum: 50 }, allow_blank: true
    
  before_save :set_settings_cnt
  validate :settings_should_be_correct
  
  validates_presence_of :setting1_name, if: "setting1_name.blank? && !setting2_name.blank?", message: "can't be blank when Setting2 name is present"
  validates_presence_of :setting2_name, if: "setting2_name.blank? && !setting3_name.blank?", message: "can't be blank when Setting3 name is present"
  validates_presence_of :setting3_name, if: "setting3_name.blank? && !setting4_name.blank?", message: "can't be blank when Setting4 name is present"
  validates_presence_of :setting4_name, if: "setting4_name.blank? && !setting5_name.blank?", message: "can't be blank when Setting5 name is present"

  private

  def set_settings_cnt
    self.settings_cnt = 0
    self.settings_cnt += 1 unless setting1_name.blank?
    self.settings_cnt += 1 unless setting2_name.blank?
    self.settings_cnt += 1 unless setting3_name.blank?
    self.settings_cnt += 1 unless setting4_name.blank?
    self.settings_cnt += 1 unless setting5_name.blank?
  end
  
  def settings_should_be_correct
    validate_setting(:setting1_value, setting1_name, setting1_type, setting1_value)
    validate_setting(:setting2_value, setting2_name, setting2_type, setting2_value)
    validate_setting(:setting3_value, setting3_name, setting3_type, setting3_value)
    validate_setting(:setting4_value, setting4_name, setting4_type, setting4_value)
    validate_setting(:setting5_value, setting5_name, setting5_type, setting5_value)
  end
  
  def validate_setting(attr_name, setting_name, setting_type, setting_value)
    errors.add(attr_name, "can't be blank") if setting_name.present? && setting_value.blank?
    if setting_name.present? and setting_value.present?
      errors.add(attr_name, "invalid format, the correct format is yyyy-mm-dd") if (setting_type == "date" && setting_value =~ /\A\d{4}\-\d{2}\-\d{2}+$\z/).nil?
      Time.zone.parse setting_value rescue errors.add(attr_name, "is not a date") if setting_type == "date"
      errors.add(attr_name, "is longer than maximum (100)") if setting_type == "text" && setting_value.length > 100
      errors.add(attr_name, "should include only digits") if setting_type == "number" && (setting_value =~ /\A[0-9]+$\z/).nil?
    end
  end
  
  def self.options_for_service_code(backend_code)
    ScBackendSetting.where(app_id: nil, backend_code: backend_code).pluck(:service_code)
  end

  def self.options_for_backend_code
    ScBackendSetting.where(app_id: nil).pluck('distinct backend_code')
  end
end