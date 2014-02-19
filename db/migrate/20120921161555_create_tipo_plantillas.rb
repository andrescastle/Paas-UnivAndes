class CreateTipoPlantillas < ActiveRecord::Migration
  def change
    create_table :tipo_plantillas do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
    add_index :tipo_plantillas, :nombre, :unique => true
  end
end
