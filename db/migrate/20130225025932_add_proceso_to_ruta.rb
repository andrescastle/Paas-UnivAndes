class AddProcesoToRuta < ActiveRecord::Migration
  def change
    add_column :ruta, :proceso_id, :integer
  end
end
