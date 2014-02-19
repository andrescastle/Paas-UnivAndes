class AddInstancianumeroToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :inst_num, :integer
  end
end
