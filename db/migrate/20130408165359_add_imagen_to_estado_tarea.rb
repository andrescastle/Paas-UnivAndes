class AddImagenToEstadoTarea < ActiveRecord::Migration
  def change
    add_column :estado_actividads, :imagen, :string
  end
end
