class RenameCostoUnidadToTipoRecurso < ActiveRecord::Migration
  def change
    rename_column :tipo_recursos, :costo, :cost
    rename_column :tipo_recursos, :unidad, :unit
  end
end
