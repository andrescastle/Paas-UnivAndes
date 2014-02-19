VALID_NAME = /\w/

# = Modelo de Tipo de plantilla
# Esta clase implementa el modelo en el patron MVC para la tabla de tipo_de_plantilla.
# Un tipo de plantilla es una clasificacion de las plantillas que pueden ser utilizados en diferentes proyectos.
# == Atributos
# * id : entero (llave primaria)
# * nombre : string
#
# == Relaciones
# * plantillas: Uno a muchos
#
# == Restricciones
# * nombre: requerido, caracteres alfanumericos, longitud(140), unico
class TipoPlantilla < ActiveRecord::Base
  attr_accessible :nombre,:descripcion, :id
  has_many :plantillas, dependent: :destroy
  self.primary_key = 'id'
  validates :nombre, :presence => true, format: { with:VALID_NAME }, :length => { :maximum => 140 }, uniqueness:true
end