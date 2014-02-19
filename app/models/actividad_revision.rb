class ActividadRevision < ActiveRecord::Base
  belongs_to :actividad, :foreign_key => 'actividad_id'
  belongs_to :tipo_recurso, :foreign_key => 'tipo_recurso_id'

  attr_accessible :actividad_id, :id, :nombre, :tipo_recurso_id

  validates :actividad, :presence => true
  validates :tipo_recurso, :presence => true

end
