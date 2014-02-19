class CreateTipoRecursos < ActiveRecord::Migration
  def change
    create_table :tipo_recursos do |t|
      t.string :nombre
      t.decimal :costo
      t.integer :unidad      
      t.timestamps
    end
    add_index :recursos, [:nombre], unique: true
  end
end
