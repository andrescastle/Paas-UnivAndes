class CreateTipoOrganizacions < ActiveRecord::Migration
  def change
    create_table :tipo_organizacions do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end
