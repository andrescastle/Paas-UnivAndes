class CreateArchivos < ActiveRecord::Migration
  def change
    create_table :archivos do |t|
      t.string :nombre
      t.references :tipo_archivo
      t.references :tipo_artefacto
      t.date :fcreado
      t.string :descripcion
      t.references :deposito

      t.timestamps
    end
    add_index :archivos, :tipo_archivo_id
    add_index :archivos, :tipo_artefacto_id
    add_index :archivos, :deposito_id
  end
end
