class AddUnidadesToTareaRecurso < ActiveRecord::Migration
  def change
    remove_column :tarea_recursos, :esfuerzo
    remove_column :tarea_recursos, :unidad_esfuerzo
    add_column :tarea_recursos, :unidades, :integer
  end

end
