class CreateTareaParticipantes < ActiveRecord::Migration
  def change
    create_table :tarea_participantes do |t|
      t.integer :id
      t.integer :tarea_id
      t.integer :usuario_id
      t.integer :dedicacion

      t.timestamps
    end
  end
end
