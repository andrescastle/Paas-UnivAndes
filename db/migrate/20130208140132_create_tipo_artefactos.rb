class CreateTipoArtefactos < ActiveRecord::Migration
  def change
    create_table :tipo_artefactos do |t|
      t.string :nombre
      t.string :descripcion
      t.string :logo

      t.timestamps
    end
    add_index :tipo_artefactos, :nombre, :unique => true
  end
end
