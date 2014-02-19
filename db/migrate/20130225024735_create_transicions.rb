class CreateTransicions < ActiveRecord::Migration
  def change
    create_table :transicions do |t|
      t.integer :id
      t.string :nombre
      t.string :tipo_inicio
      t.integer :incio_id
      t.string :tipo_fin
      t.integer :fin_id
      t.integer :proceso_id

      t.timestamps
    end
  end
end
