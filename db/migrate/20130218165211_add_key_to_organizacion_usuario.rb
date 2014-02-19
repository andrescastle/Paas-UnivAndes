class AddKeyToOrganizacionUsuario < ActiveRecord::Migration
  def change
    add_index :usuarios, :organizacion_id
  end
end
