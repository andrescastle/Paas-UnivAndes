class CreateTipoDepositos < ActiveRecord::Migration
  def change
    create_table :tipo_depositos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
