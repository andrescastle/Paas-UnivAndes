class AddSessionToDeposito < ActiveRecord::Migration
  def change
    add_column :depositos, :session, :string
  end
end
