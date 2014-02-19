class AddFilenameToProceso < ActiveRecord::Migration
  def change
    add_column :procesos, :filename, :string
  end
end
