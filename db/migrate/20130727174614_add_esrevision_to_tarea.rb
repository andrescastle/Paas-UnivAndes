class AddEsrevisionToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :revision_id, :integer
  end
end
