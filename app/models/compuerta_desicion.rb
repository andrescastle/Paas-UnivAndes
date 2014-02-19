class CompuertaDesicion < ActiveRecord::Base
  belongs_to :compuertu, :foreign_key => 'compuerta_id'
  belongs_to :rutum, :foreign_key => 'ruta_id'
  belongs_to :tarea, :foreign_key => 'tarea_desicion_id'

  attr_accessible :compuerta_id, :elegida, :id, :ruta_id, :tarea_desicion_id
end
