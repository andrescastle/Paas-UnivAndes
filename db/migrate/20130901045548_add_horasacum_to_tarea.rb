class AddHorasacumToTarea < ActiveRecord::Migration
  def change
    add_column :tareas, :horas_acumuladas, :integer
  end
end
