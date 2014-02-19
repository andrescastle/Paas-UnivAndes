class AddHorasToActividad < ActiveRecord::Migration
  def change
    remove_column :actividads, :unidad_tiempo
    add_column :actividads, :horas_estimadas, :integer
  end

  add_index :tareas, :proceso_id
  add_index :tareas, :responsable_id
end
