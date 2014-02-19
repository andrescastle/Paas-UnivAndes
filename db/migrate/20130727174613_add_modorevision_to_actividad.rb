class AddModorevisionToActividad < ActiveRecord::Migration
  def change
    add_column :actividads, :modo_revision, :string
  end
end
