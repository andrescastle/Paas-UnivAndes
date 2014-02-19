class CreateDepositos < ActiveRecord::Migration
  def change
    create_table :depositos do |t|
      t.string :nombre
      t.references :tipo_deposito
      t.date :fcreado
      t.string :usuario
      t.string :contrasena

      t.timestamps
    end
    add_index :depositos, :tipo_deposito_id
  end
end
