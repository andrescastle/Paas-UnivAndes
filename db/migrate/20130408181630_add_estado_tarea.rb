class AddEstadoTarea < ActiveRecord::Migration
  def change
    remove_column :tareas, :estado
    add_column :tareas, :estado, :integer
  end
end
