class AddTurnoToTareaRevisions < ActiveRecord::Migration
  def change
    add_column :tarea_revisions, :turno, :integer
  end
end
