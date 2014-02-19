VALID_NAME = /\w/
VALID_UNIDADES =/[0-9]/
# = Modelo de actividad
# Esta clase implementa el modelo en el patron MVC para la tabla de actividades.
# Una actividad es una tarea de usuario dentro del estandar BPMN.
# == Atributos
# * id : entero (llave primaria)
# * nombre : string
# * plantilla_id : entero
# * descripcion : string
# * modoejecucion : entero
# * imagen : file
#
# == Relaciones
# * plantilla: pertenencia
#
# == Restricciones
# * nombre: requerido, caracteres alfanumericos, longitud(140), unico
# * plantilla_id: requerido
# * modoejecucion: requerido
class Actividad < ActiveRecord::Base

  belongs_to :my_js_tree,  :foreign_key => 'my_js_tree_id', dependent: :destroy
  belongs_to :plantilla,  :foreign_key => 'plantilla_id'
  belongs_to :proceso,  :foreign_key => 'proceso_id'
  belongs_to :estado_actividad,  :foreign_key => 'estado'
  belongs_to :usuario,  :foreign_key => 'responsable_id'

  has_many :actividad_tiporecurso, dependent: :destroy
  has_many :tipo_recursos, :through => :actividad_tiporecurso
  has_many :actividad_tipoartefacto, dependent: :destroy
  has_many :tipo_artefactos, :through => :actividad_tipoartefacto
  has_many :actividad_revision,  dependent: :destroy
  has_many :tareas, dependent: :destroy

  attr_accessible :descripcion,
                  :modoejecucion,
                  :nombre,
                  :imagen,
                  :plantilla_id,
                  :proceso_id,
                  :duracion,
                  :my_js_tree_id,
                  :estado,
                  :responsable_id,
                  :num_instancias,
                  :horas_estimadas,
                  :tipocontrol,
                  :modo_revision

  self.primary_key = 'id'

  validates :nombre, :presence => true , format: { with:VALID_NAME }, :length => { :maximum => 140 }
  validates :modoejecucion, :presence => true

  has_attached_file :imagen, :url => "/images/actividades/:id_:style.:extension",
                             :path => ":rails_root/public/images/actividades/:id_:style.img",
                             :default_url => "/images/default/missing_:style.png"

  attr_accessor :imagen_file_name
  attr_accessor :imagen_content_type
  attr_accessor :imagen_file_size
  attr_accessor :imagen_updated_at

  validates_attachment_size :imagen, :less_than => 1.megabytes
  validates_attachment_content_type :imagen, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp']

end
