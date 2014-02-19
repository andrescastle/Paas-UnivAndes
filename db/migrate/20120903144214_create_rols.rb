class CreateRols < ActiveRecord::Migration
  def change
    create_table :rols do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
    add_index :rols
  end
end
