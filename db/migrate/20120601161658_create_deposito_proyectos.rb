class CreateDepositoProyectos < ActiveRecord::Migration
  def change
    create_table :deposito_proyectos do |t|
      t.references :deposito
      t.references :proyecto

      t.timestamps
    end
    add_index :deposito_proyectos, :deposito_id
    add_index :deposito_proyectos, :proyecto_id
    add_index :deposito_proyectos,[:deposito_id, :proyecto_id], unique: true
  end
end
