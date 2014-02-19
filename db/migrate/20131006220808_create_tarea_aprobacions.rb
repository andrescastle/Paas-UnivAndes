class CreateTareaAprobacions < ActiveRecord::Migration
  def change
    create_table :tarea_aprobacions do |t|
      t.integer :tarea_id
      t.boolean :aprobado
      t.string :comentario
      t.integer :usuario_id

      t.timestamps
    end
  end
end
