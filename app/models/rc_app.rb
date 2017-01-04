class RcApp < ActiveRecord::Base
  audited

  enum udf_types: [:number, :date, :text]
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  store :udf1, accessors: [:udf1_name, :udf1_type, :udf1_is_mandatory], coder: JSON
  store :udf2, accessors: [:udf2_name, :udf2_type, :udf2_is_mandatory], coder: JSON
  store :udf3, accessors: [:udf3_name, :udf3_type, :udf3_is_mandatory], coder: JSON
  store :udf4, accessors: [:udf4_name, :udf4_type, :udf4_is_mandatory], coder: JSON
  store :udf5, accessors: [:udf5_name, :udf5_type, :udf5_is_mandatory], coder: JSON

  validates_presence_of :app_id
  
  validates_uniqueness_of :app_id
  
  before_save :set_udf_cnt
  
  private

  def set_udf_cnt
    self.udfs_cnt = 0
    self.udfs_cnt += 1 unless udf1_name.blank?
    self.udfs_cnt += 1 unless udf2_name.blank?
    self.udfs_cnt += 1 unless udf3_name.blank?
    self.udfs_cnt += 1 unless udf4_name.blank?
    self.udfs_cnt += 1 unless udf5_name.blank?      
  end 
  
end