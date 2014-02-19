class CreateActividadTipoartefactos < ActiveRecord::Migration
  def change
    create_table :actividad_tipoartefactos do |t|
      t.integer :id
      t.integer :actividad_id
      t.integer :tipo_artefacto_id
      t.string :modo

      t.timestamps
    end

    add_index :actividad_tipoartefactos, :actividad_id
    add_index :actividad_tipoartefactos, :tipo_artefacto_id
  end
end
