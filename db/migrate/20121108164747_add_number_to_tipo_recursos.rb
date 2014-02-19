class AddNumberToTipoRecursos < ActiveRecord::Migration
  def change
    add_column :tipo_recursos, :number, :integer
  end
end
