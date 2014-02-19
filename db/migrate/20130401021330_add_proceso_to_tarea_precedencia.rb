class AddProcesoToTareaPrecedencia < ActiveRecord::Migration
  def change
    add_column :tarea_presedencia, :proceso_id, :integer
  end
end
