class AddProcesoToMyJosTree < ActiveRecord::Migration
  def change
    add_column :my_js_trees, :proceso_id, :integer
  end
end
