class AddTipoToOrganizacion < ActiveRecord::Migration
  def change
    add_column :organizacions, :tipo_organizacion_id, :int
  end
end
