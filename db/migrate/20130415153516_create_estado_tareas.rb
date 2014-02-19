class CreateEstadoTareas < ActiveRecord::Migration
  def change
    create_table :estado_tareas do |t|
      t.references :tareas
      t.references :estado_actividads

      t.timestamps
    end
    add_index :estado_tareas, :tareas_id
    add_index :estado_tareas, :estado_actividads_id
  end
end
