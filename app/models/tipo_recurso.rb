VALID_NAME = /\w/
VALID_UNIDADES =/[0-9]/
VALID_COSTO =/^\d+\.?\d*$/

# = Modelo de Tipo de Recurso
# Esta clase implementa el modelo en el patron MVC para la tabla de tipo_de_recursos.
# Un tipo de recurso es una clasificacion de los recursos que pueden ser utilizados en diferentes proyectos.
# == Atributos
# * id : entero (llave primaria)
# * nombre : string
#
# == Relaciones
# * recursos: Uno a muchos
#
# == Restricciones
# * nombre: requerido, caracteres alfanumericos, longitud(140), unico
class TipoRecurso < ActiveRecord::Base
  attr_accessible :nombre, :id, :cost, :unit
  has_many :recursos, dependent: :destroy
  has_many :actividad_tiporecurso, dependent: :destroy
  has_many :actividads, :through => :actividad_tiporecurso
  self.primary_key = 'id'
  validates :nombre, :presence => true, format: { with:VALID_NAME }, :length => { :maximum => 140 }, uniqueness:true
  validates :unit, :presence => true, format: { with:VALID_UNIDADES }
end
