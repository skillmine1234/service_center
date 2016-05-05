class Atom < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "atom_#{Rails.env}"
end