class CreateCompuertaPreDesicions < ActiveRecord::Migration
  def change
    create_table :compuerta_pre_desicions do |t|
      t.integer :compuerta_id
      t.integer :ruta_id
      t.boolean :elegida
      t.integer :tarea_desicion_id

      t.timestamps
    end
  end
end
