class AddOrganizacionToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :organizacion_id, :integer
  end


end
