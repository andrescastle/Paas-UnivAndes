class AddColumnaToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :columna, :integer
  end
end
