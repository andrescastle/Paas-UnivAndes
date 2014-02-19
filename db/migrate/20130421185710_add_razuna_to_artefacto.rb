class AddRazunaToArtefacto < ActiveRecord::Migration
  def change
    remove_column :artefactos, :tipo_artefacto_id
    remove_column :artefactos, :imagen
    remove_column :artefactos, :descripcion
    add_column :artefactos, :razuna_key, :string
  end
end
