class ProyectoArtefacto < ActiveRecord::Base
  belongs_to :proyecto, :foreign_key => 'proyecto_id'
  belongs_to :artefacto, :foreign_key => 'artefacto_id'
  attr_accessible :artefacto_id, :proyecto_id
end
