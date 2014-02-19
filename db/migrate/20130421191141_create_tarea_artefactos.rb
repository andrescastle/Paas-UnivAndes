class CreateTareaArtefactos < ActiveRecord::Migration
  def change
    create_table :tarea_artefactos do |t|
      t.integer :id
      t.integer :tarea_id
      t.integer :artefacto_id
      t.string :modo

      t.timestamps
    end
  end
end
