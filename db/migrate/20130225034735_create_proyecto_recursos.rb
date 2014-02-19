class CreateProyectoRecursos < ActiveRecord::Migration
  def change
    create_table :proyecto_recursos do |t|
      t.integer :proyecto_id
      t.integer :recurso_id

      t.timestamps
    end
  end
end
