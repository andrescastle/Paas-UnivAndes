class CreateActividadTiporecursos < ActiveRecord::Migration
  def change
    create_table :actividad_tiporecursos do |t|
      t.references :actividad
      t.references :tipo_recurso
      t.integer :cantidad
      t.timestamps
    end
    add_index :actividad_tiporecursos, :actividad_id
    add_index :actividad_tiporecursos, :tipo_recurso_id
    add_index :actividad_tiporecursos,[:actividad_id, :tipo_recurso_id], unique: true
  end
end
