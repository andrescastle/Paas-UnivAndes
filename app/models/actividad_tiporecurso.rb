VALID_UNIDADES =/[0-9]/
class ActividadTiporecurso < ActiveRecord::Base
  belongs_to :actividad, :foreign_key => 'actividad_id'
  belongs_to :tipo_recurso, :foreign_key => 'tipo_recurso_id'
  # attr_accessible :title, :body
  attr_accessible :actividad_id, :tipo_recurso_id, :cantidad

   validates :actividad, :presence => true
   validates :tipo_recurso, :presence => true
   validates :cantidad, :presence => true, format: { with:VALID_UNIDADES }
end
