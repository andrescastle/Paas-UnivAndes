class AddTurnoToActividadRevisions < ActiveRecord::Migration
  def change
    add_column :actividad_revisions, :turno, :integer
  end
end
