class TareaRevision < ActiveRecord::Base
  belongs_to :tarea, :foreign_key => 'tarea_id'
  belongs_to :usuario, :foreign_key => 'usuario_id'

  attr_accessible :aprobado, :comentario, :id, :tarea_id, :usuario_id
end
