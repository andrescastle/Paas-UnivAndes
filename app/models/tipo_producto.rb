class TipoProducto < ActiveRecord::Base
  attr_accessible :descripcion, :nombre, :id
   self.primary_key = 'id'
  has_many :productos, dependent: :destroy 
  validates :nombre, :presence => true
end
