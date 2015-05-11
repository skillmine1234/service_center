class RemittanceReview < ActiveRecord::Base
  attr_accessible :created_by, :justification_code, :justification_text, :lock_version, 
                  :review_remarks, :review_status, :reviewed_at, :reviewed_by, :transaction_id, 
                  :updated_by
end
