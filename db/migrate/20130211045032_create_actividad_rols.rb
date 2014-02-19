class CreateActividadRols < ActiveRecord::Migration
  def change
    create_table :actividad_rols do |t|
      t.integer :id
      t.integer :actividad_id
      t.integer :rol_id

      t.timestamps
    end

    add_index :actividad_rols, :actividad_id
    add_index :actividad_rols, :rol_id
  end
end
