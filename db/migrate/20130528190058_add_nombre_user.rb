class AddNombreUser < ActiveRecord::Migration
  def change
    add_column :users , :nombre, :string
    add_column :users , :apellidos, :string
    add_column :users , :password_confirm,:string
    add_column :users , :tipo_recurso_id, :integer
    add_column :users , :login, :string
  end
end
