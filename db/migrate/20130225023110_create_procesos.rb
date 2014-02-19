class CreateProcesos < ActiveRecord::Migration
  def change
    create_table :procesos do |t|
      t.integer :id
      t.string :nombre
      t.string :descripcion
      t.integer :tipo_plantilla_id
      t.integer :proyecto_id

      t.timestamps
    end
  end
end
