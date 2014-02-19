class CreateTareas < ActiveRecord::Migration
  def change
    create_table :tareas do |t|
      t.integer :id
      t.string :nombre
      t.string :descripcion
      t.integer :actividad_id
      t.date :fecha_inicio
      t.date :fecha_fin
      t.integer :responsable_id
      t.string :estado
      t.integer :prioridad
      t.string :comentarios
      t.float :avance
      t.integer :esfuerzo
      t.string :unidad_esfuerzo

      t.timestamps
    end
  end
end
