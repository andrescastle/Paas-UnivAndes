class CreateProyectos < ActiveRecord::Migration
  def change
    create_table :proyectos do |t|
      t.string :nombre
      t.references :tipo_producto
      t.date :fcreado
      t.string :descripcion
      t.binary :logo
      t.string  :filename
      t.string :content_type
      t.integer :size

      t.timestamps
    end
    add_index :proyectos, :tipo_producto_id
  end
end
