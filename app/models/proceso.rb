class Proceso < ActiveRecord::Base
  belongs_to :tipo_plantilla, :foreign_key => 'tipo_plantilla_id'
  belongs_to :proyecto, :foreign_key => 'proyecto_id'
  self.primary_key = 'id'
  attr_accessible :descripcion, :id, :nombre, :proyecto_id, :tipo_plantilla_id, :estado

  has_many :actividads, dependent: :destroy
  has_many :tareas, dependent: :destroy
  has_many :compuertus, dependent: :destroy
  has_many :eventos, dependent: :destroy
  has_many :ruta, dependent: :destroy
  has_many :transicion, dependent: :destroy
  has_many :my_js_trees, dependent: :destroy

  validates :nombre, :presence => true

end
