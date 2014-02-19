class AddActivadaToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :activada, :boolean
    remove_column :tareas, :revision_id
  end
end
