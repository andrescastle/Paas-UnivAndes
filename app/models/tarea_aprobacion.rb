class TareaAprobacion < ActiveRecord::Base
  belongs_to :tarea, :foreign_key => 'tarea_id'
  attr_accessible :aprobado, :comentario, :tarea_id, :usuario_id
end
