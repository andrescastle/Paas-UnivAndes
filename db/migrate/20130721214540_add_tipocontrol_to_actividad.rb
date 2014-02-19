class AddTipocontrolToActividad < ActiveRecord::Migration
  def change
    add_column :actividads, :tipocontrol, :string
  end
end
