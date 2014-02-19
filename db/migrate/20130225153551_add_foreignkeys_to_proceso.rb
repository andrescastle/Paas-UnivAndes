class AddForeignkeysToProceso < ActiveRecord::Migration
  def change
    add_index :actividads, :proceso_id
    add_index :compuertus, :proceso_id
    add_index :eventos, :proceso_id
    add_index :ruta, :proceso_id
    add_index :my_js_trees, :proceso_id
    add_index :transicions, :proceso_id
    add_index :procesos, :proyecto_id
  end
end
