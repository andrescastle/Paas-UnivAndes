class AddProcesoToCompuertu < ActiveRecord::Migration
  def change
    add_column :compuertus, :proceso_id, :integer
  end
end
