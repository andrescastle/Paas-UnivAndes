class AddColumnsToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :duracion, :integer
    add_column :tareas, :horas_planeadas, :integer
    add_column :tareas, :horas_ejecutadas, :integer
    remove_column :tareas, :esfuerzo
    remove_column :tareas, :unidad_esfuerzo
  end

  add_index :tareas, :actividad_id
end
