class ScBackendStatus < ActiveRecord::Base
  self.table_name = 'sc_backend_status'
  validates_presence_of :code
  validates_uniqueness_of :code

  belongs_to :sc_backend, :foreign_key => 'code', :primary_key => 'code'
end
