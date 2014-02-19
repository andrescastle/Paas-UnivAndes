class AddCuentaToDeposito < ActiveRecord::Migration
  def change
    add_column :depositos, :cuenta, :string
  end
end
