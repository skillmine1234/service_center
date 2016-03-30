class SuAuditStep < ActiveRecord::Base  
  belongs_to :su_auditable, :polymorphic => true
  
  def response_time
    ((self.rep_timestamp - self.req_timestamp) * 1000).round rescue '0'
  end
end
