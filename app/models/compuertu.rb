VALID_NAME = /\w/
# = Modelo de compuerta
# Esta clase implementa el modelo en el patron MVC para la tabla de compuertas.
# Una compuerta es una descición dentro del estandar BPMN.
# == Atributos
# * id : entero (llave primaria)
# * nombre : string
# * plantilla_id : entero
# * descripcion : string
# * tipo : entero
# * desicion : entero
#
# == Relaciones
# * plantilla: pertenencia
#
# == Restricciones
# * nombre: requerido, caracteres alfanumericos, longitud(140), unico
# * plantilla_id: requerido
# * tipo: requerido
# * descicion: requerido
class Compuertu < ActiveRecord::Base
  belongs_to :plantilla, :foreign_key => 'plantilla_id'
  belongs_to :proceso,  :foreign_key => 'proceso_id'
  belongs_to :my_js_tree,  :foreign_key => 'my_js_tree_id', dependent: :destroy

  has_many :compuerta_desicions, dependent: :destroy

  attr_accessible :descripcion, :desicion, :nombre, :tipo, :plantilla_id, :proceso_id, :my_js_tree_id
  self.primary_key = 'id'

   validates :nombre, :presence => true , format: { with:VALID_NAME }, :length => { :maximum => 140 }
   validates :tipo, :presence => true

  has_attached_file :imagen, :url => "/images/compuertas/:id_:style.:extension",
                    :path => ":rails_root/public/images/compuertas/:id_:style.img",
                    :default_url => "/images/default/missing_:style.png"

  attr_accessor :imagen_file_name
  attr_accessor :imagen_content_type
  attr_accessor :imagen_file_size
  attr_accessor :imagen_updated_at

  validates_attachment_size :imagen, :less_than => 1.megabytes
  validates_attachment_content_type :imagen, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp']

end
