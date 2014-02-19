class AddOrganizacionToProyecto < ActiveRecord::Migration
  def change
    add_column :proyectos, :organizacion_id, :integer
  end
end
