class ScBackendStat < ActiveRecord::Base
  validates_presence_of :code
  validates_uniqueness_of :code
end
