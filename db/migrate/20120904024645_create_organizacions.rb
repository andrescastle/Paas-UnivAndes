class CreateOrganizacions < ActiveRecord::Migration
  def change
    create_table :organizacions do |t|
      t.string :nit
      t.string :nombre
      t.string :descripcion
      t.integer :naturaleza
      t.string :representante
      t.string :direccion
      t.string :telefono
      t.references :recurso

      t.timestamps
    end
    add_index :organizacions, :recurso_id
  end
end
