class CreateArtefactos < ActiveRecord::Migration
  def change
    create_table :artefactos do |t|
      t.integer :id
      t.string :nombre
      t.integer :tipo_artefacto_id
      t.string :imagen
      t.string :descripcion

      t.timestamps
    end
  end
end
