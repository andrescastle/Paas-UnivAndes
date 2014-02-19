class CreateArchivoProyectos < ActiveRecord::Migration
  def change
    create_table :archivo_proyectos do |t|
      t.references :archivo
      t.references :proyecto

      t.timestamps
    end
    add_index :archivo_proyectos, :archivo_id
    add_index :archivo_proyectos, :proyecto_id
    add_index :archivo_proyectos,[:archivo_id, :proyecto_id], unique: true
  end
end
