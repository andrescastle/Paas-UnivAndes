class CreateCompuertaDesicions < ActiveRecord::Migration
  def change
    create_table :compuerta_desicions do |t|
      t.integer :id
      t.integer :compuerta_id
      t.integer :ruta_id
      t.boolean :elegida

      t.timestamps
    end
  end
end
