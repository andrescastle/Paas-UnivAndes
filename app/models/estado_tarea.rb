class EstadoTarea < ActiveRecord::Base
  belongs_to :tareas
  belongs_to :estado_actividads
  # attr_accessible :title, :body
end
