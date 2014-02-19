class CreateRolesUsuarios < ActiveRecord::Migration
  def up
    create_table :roles_usuarios, :id => false do |t|
      t.references :role, :usuarios
    end
  end

  def down
    drop_table :roles_usuarios
  end
end
