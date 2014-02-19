class CreatePlantillas < ActiveRecord::Migration
  def change
    create_table :plantillas do |t|
      t.string :nombre
      t.references :tipo_plantilla
      t.text :descripcion
      t.timestamps
    end
    add_attachment :plantillas, :imagen
    add_index :plantillas, :nombre, :unique => true
    add_index :plantillas, :tipo_plantilla_id
  end

end
