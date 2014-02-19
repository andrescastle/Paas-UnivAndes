class AddAprobacionToTarea < ActiveRecord::Migration
  def change
    add_column :tarea_revisions, :aprobado, :boolean
  end
end
