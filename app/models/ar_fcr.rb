class ArFcr < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "fcr_#{Rails.env}"
end