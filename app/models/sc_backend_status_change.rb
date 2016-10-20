class ScBackendStatusChange < ActiveRecord::Base
  validates_presence_of :code, :new_status, :remarks
  validates_uniqueness_of :code

  validates :code, length: { maximum: 20 }
  validates :new_status, length: { minimum: 1, maximum: 1 }

  belongs_to :sc_backend, :foreign_key => 'code', :primary_key => 'code'
end
