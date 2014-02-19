class AddForeignkeysToProyecto < ActiveRecord::Migration
  def change
    add_index :proyecto_artefactos, :proyecto_id
    add_index :proyecto_artefactos, :artefacto_id
    add_index :proyecto_recursos, :proyecto_id
    add_index :proyecto_recursos, :recurso_id
    add_index :proyecto_organizacions, :proyecto_id
    add_index :proyecto_organizacions, :organizacion_id
    add_index :proyecto_usuarios, :proyecto_id
    add_index :proyecto_usuarios, :usuario_id
  end
end
