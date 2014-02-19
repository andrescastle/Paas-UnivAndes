class AddIndexToProyecto < ActiveRecord::Migration
  def change
    add_column :proyectos, :presupuesto, :float
  end

  add_index :proyectos, :director
end
