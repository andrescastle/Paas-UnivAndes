class CreateActividads < ActiveRecord::Migration
  def change
    create_table :actividads do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :modoejecucion
      t.integer  :duracion
      t.references :plantilla
      t.references :my_js_tree

      t.timestamps
    end
    add_attachment :actividads, :imagen
    add_index :actividads, :plantilla_id, :my_js_tree_id
  end
end
