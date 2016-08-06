class PcApp < ActiveRecord::Base
  include Approval
  include PcApproval

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :pc_program, :foreign_key => 'program_code', :primary_key => 'code',:class_name => 'PcProgram'
  
  validates_presence_of :app_id, :program_code, :card_acct, :sc_gl_income, :card_cust_id, :traceid_prefix, :source_id, :channel_id, :identity_user_id
  validates_uniqueness_of :app_id, :scope => :approval_status
  
  validates :card_acct, :sc_gl_income, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }, length: {maximum: 15, minimum: 1}
  validates :card_cust_id, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => "Invalid format, expected format is : {[a-z|A-Z|0-9]}" }

  before_save :set_mm_columns

  def set_mm_columns
    unless self.frozen?
      unless pc_program.nil?
        self.mm_host = self.pc_program.try(:mm_host)
        self.mm_consumer_key = self.pc_program.try(:mm_consumer_key)
        self.mm_consumer_secret = self.pc_program.try(:mm_consumer_secret)
        self.mm_card_type = self.pc_program.try(:mm_card_type)
        self.mm_email_domain = self.pc_program.try(:mm_email_domain)
        self.mm_admin_host = self.pc_program.try(:mm_admin_host)
        self.mm_admin_user = self.pc_program.try(:mm_admin_user)
        self.mm_admin_password = self.pc_program.try(:mm_admin_password)
      end
    end
  end
end
