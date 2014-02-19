class CreateTareaRecursos < ActiveRecord::Migration
  def change
    create_table :tarea_recursos do |t|
      t.integer :id
      t.integer :tarea_id
      t.integer :recurso_id
      t.integer :esfuerzo
      t.integer :unidad_esfuerzo

      t.timestamps
    end
  end
end
