class AddPasswordConfirmToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :password_confirm, :string
  end
end
