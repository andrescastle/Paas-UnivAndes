class AddProcesoToActividad < ActiveRecord::Migration
  def change
    add_column :actividads, :proceso_id, :integer
  end
end
