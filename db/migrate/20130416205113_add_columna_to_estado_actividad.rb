class AddColumnaToEstadoActividad < ActiveRecord::Migration
  def change
    add_column :estado_actividads, :columna, :integer
  end
end
