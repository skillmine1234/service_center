class Fcr::CustomerAccount < ArFcr
  self.table_name = 'ch_acct_cust_xref'
  
  belongs_to :customer, foreign_key: :cod_cust
  
  scope :allowed_corporate_relationships, -> { where("#{self.table_name}.cod_acct_cust_rel in ('GUR', 'JOF', 'JOO', 'SOW', 'TRU','AUS')") }
end