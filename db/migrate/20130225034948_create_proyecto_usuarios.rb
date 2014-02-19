class CreateProyectoUsuarios < ActiveRecord::Migration
  def change
    create_table :proyecto_usuarios do |t|
      t.integer :proyecto_id
      t.integer :usuario_id

      t.timestamps
    end
  end
end
