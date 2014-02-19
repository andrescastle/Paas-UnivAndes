class CreateTipoArchivos < ActiveRecord::Migration
  def change
    create_table :tipo_archivos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
