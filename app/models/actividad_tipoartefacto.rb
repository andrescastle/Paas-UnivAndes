class ActividadTipoartefacto < ActiveRecord::Base
  belongs_to :actividad, :foreign_key => 'actividad_id'
  belongs_to :tipo_artefacto, :foreign_key => 'tipo_artefacto_id'

  attr_accessible :actividad_id, :id, :modo, :tipo_artefacto_id

  validates :actividad, :presence => true
  validates :tipo_artefacto, :presence => true
  validates :modo, :presence => true
end
