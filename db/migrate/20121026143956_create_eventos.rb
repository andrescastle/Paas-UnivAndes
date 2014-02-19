class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :tipo
      t.references :plantilla
      t.references :my_js_tree

      t.timestamps
    end
    add_index :eventos, :plantilla_id
    add_index :eventos, :my_js_tree_id
  end
end
