class CreateRuta < ActiveRecord::Migration
  def change
    create_table :ruta do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :tipo
      t.references :plantilla
      t.references :my_js_tree

      t.timestamps
    end
    add_index :ruta, :plantilla_id
    add_index :ruta, :my_js_tree_id
  end
end
