class AddTareaToCompuertadesicion < ActiveRecord::Migration
  def change
    add_column :compuerta_desicions, :tarea_desicion_id, :integer
  end
end
