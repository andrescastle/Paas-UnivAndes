class AddColumnsToActividad < ActiveRecord::Migration
  def change
    add_column :actividads, :estado, :string
    add_column :actividads, :num_instancias, :integer
    add_column :actividads, :unidad_tiempo, :string
    add_column :actividads, :responsable_id, :integer
  end
end
