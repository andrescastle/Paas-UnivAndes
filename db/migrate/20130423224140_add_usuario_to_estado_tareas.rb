class AddUsuarioToEstadoTareas < ActiveRecord::Migration
  def change
    add_column :estado_tareas, :usuario_id, :integer
  end
end
