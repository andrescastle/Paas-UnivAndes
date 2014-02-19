class AddCostoUnidadToTipoRecursos < ActiveRecord::Migration
  def change
    add_column :tipo_recursos, :costo, :decimal
    add_column :tipo_recursos, :unidad, :integer
  end
end
