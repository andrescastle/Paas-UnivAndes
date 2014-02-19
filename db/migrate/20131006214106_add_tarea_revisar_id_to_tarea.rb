class AddTareaRevisarIdToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :tarea_revisar_id, :integer
  end
end
