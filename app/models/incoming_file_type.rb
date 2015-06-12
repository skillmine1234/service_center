class IncomingFileType < ActiveRecord::Base
  validates_presence_of :code, :name, :sc_service_id
  validates_uniqueness_of :code,:name, :sc_service_id
end
