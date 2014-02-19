class ProyectoRecurso < ActiveRecord::Base
  belongs_to :proyecto, :foreign_key => 'proyecto_id'
  belongs_to :recurso, :foreign_key => 'recurso_id'
  attr_accessible :proyecto_id, :recurso_id
end
