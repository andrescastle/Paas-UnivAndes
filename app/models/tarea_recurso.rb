class TareaRecurso < ActiveRecord::Base
  belongs_to :tarea, :foreign_key => 'tarea_id'
  belongs_to :recurso, :foreign_key => 'recurso_id'
  attr_accessible :unidades, :id, :tarea_id, :recurso_id
end
