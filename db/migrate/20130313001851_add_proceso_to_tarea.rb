class AddProcesoToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :proceso_id, :integer
  end
end
