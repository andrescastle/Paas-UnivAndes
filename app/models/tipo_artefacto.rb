VALID_NAME = /\w/

class TipoArtefacto < ActiveRecord::Base
  attr_accessible :descripcion, :id, :nombre
  has_many :archivos, dependent: :destroy
  has_many :actividad_tipoartefactos, dependent: :destroy
  has_many :actividads, :through => :actividad_tipoartefactos
  self.primary_key = 'id'
  validates :nombre, :presence => true, format: { with:VALID_NAME }, :length => { :maximum => 140 }, uniqueness:true
end
