class AddEjecutadasToTareaParticipantes < ActiveRecord::Migration
  def change
    add_column :tarea_participantes, :ejecutadas, :integer
  end
end
