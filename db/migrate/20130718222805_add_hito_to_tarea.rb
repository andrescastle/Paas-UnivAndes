class AddHitoToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :hito, :boolean
  end
end
