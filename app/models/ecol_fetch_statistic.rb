class EcolFetchStatistic < ActiveRecord::Base
  
  validates_presence_of :last_neft_at, :last_neft_id, :last_neft_cnt, :tot_neft_cnt, :last_rtgs_at, :last_rtgs_id, :last_rtgs_cnt, :tot_rtgs_cnt
end
