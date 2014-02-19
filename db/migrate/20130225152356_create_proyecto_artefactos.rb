class CreateProyectoArtefactos < ActiveRecord::Migration
  def change
    create_table :proyecto_artefactos do |t|
      t.integer :proyecto_id
      t.integer :artefacto_id

      t.timestamps
    end
  end
end
