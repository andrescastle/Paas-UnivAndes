class AddEsAprobacionToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :es_aprobacion, :boolean
  end
end
