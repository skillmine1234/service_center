class ArFcatrt < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "fcatrt_#{Rails.env}"
end