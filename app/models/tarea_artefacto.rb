class TareaArtefacto < ActiveRecord::Base
  belongs_to :tarea, :foreign_key => 'tarea_id'
  belongs_to :artefacto, :foreign_key => 'artefacto_id'
  attr_accessible :artefacto_id, :id, :modo, :tarea_id
end
