class AddEstadoToProceso < ActiveRecord::Migration
  def change
    add_column :procesos, :estado, :string
  end
end
