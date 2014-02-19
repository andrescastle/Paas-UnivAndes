class CreateRecursos < ActiveRecord::Migration
  def change
    create_table :recursos do |t|
      t.string :nombre
      t.references :tipo_recurso
      t.decimal :costo
      t.integer :unidades
      t.text :descripcion
      t.references :organizacion

      t.timestamps
    end
    add_index :recursos, :tipo_recurso_id
    add_index :recursos, :organizacion_id
    add_index :recursos, [:nombre,:organizacion_id], unique: true
  end
end
