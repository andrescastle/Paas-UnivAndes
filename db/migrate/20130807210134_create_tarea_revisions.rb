class CreateTareaRevisions < ActiveRecord::Migration
  def change
    create_table :tarea_revisions do |t|
      t.integer :id
      t.integer :tarea_id
      t.integer :usuario_id
      t.string :comentario

      t.timestamps
    end
  end
end
