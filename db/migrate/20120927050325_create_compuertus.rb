class CreateCompuertus < ActiveRecord::Migration
  def change
    create_table :compuertus do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :tipo
      t.integer :desicion
      t.references :plantilla
      t.references :my_js_tree

      t.timestamps
    end
     add_index :compuertus, :plantilla_id
     add_index :compuertus, :my_js_tree
  end
end
