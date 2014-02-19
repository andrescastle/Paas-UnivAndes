class CreateTipoProductos < ActiveRecord::Migration
  def change
    create_table :tipo_productos do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
