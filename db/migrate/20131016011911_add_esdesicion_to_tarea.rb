class AddEsdesicionToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :es_desicion, :boolean
    add_column :tareas, :compuerta_id, :integer
  end
end
