class CreateProyectoOrganizacions < ActiveRecord::Migration
  def change
    create_table :proyecto_organizacions do |t|
      t.integer :proyecto_id
      t.integer :organizacion_id

      t.timestamps
    end
  end
end
