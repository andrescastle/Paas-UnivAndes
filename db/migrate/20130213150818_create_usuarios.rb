class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :login
      t.integer :tipo_recurso_id
      t.string :imagen

      t.timestamps
    end
    add_index :usuarios, :tipo_recurso_id
  end
end
