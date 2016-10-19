class ScBackendStatus < ActiveRecord::Base
  self.table_name = 'sc_backend_status'

  validates_presence_of :code, :status
  validates_uniqueness_of :code

  validates :code, length: { maximum: 20 }
  validates :status, length: { minimum: 1, maximum: 1 }

  belongs_to :sc_backend, :foreign_key => 'code', :primary_key => 'code'
end
