class CreateEstadoActividads < ActiveRecord::Migration
  def change
    create_table :estado_actividads do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
