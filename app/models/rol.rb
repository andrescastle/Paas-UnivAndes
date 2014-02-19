class Rol < ActiveRecord::Base
  attr_accessible :descripcion, :nombre, :id
   self.primary_key = 'id'
  validates :nombre, :presence => true, :uniqueness => true
 
end
