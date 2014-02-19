class AddPrioridadTareaParticipante < ActiveRecord::Migration
  def change
    add_column :tarea_participantes, :prioridad, :integer
  end

end
