class PcProgram < ActiveRecord::Base
  include Approval
  include PcApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  has_many :pc_products, :foreign_key => 'program_code', :primary_key => 'code', :class_name => 'PcProduct'

  validates_presence_of :code
  validates :code, format: {with: /\A[a-z|A-Z|0-9|\-\_]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\-\_]}' }, length: {maximum: 6}

  validates_uniqueness_of :code, :scope => :approval_status

  def self.options_for_pc_programs
    PcProgram.all.collect { |pc_program| [pc_program.code, pc_program.code] }
  end

  before_save :to_downcase

  def to_downcase
    unless self.frozen?
      self.code = self.code.downcase unless self.code.nil?
    end
  end
end
