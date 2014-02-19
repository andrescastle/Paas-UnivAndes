class CreateMyJsTrees < ActiveRecord::Migration
  def change
    create_table :my_js_trees do |t|
      t.integer :parent_id
      t.integer :position
      t.integer :left
      t.integer :right
      t.integer :level
      t.string :title
      t.string :type
      t.references :plantilla

      t.timestamps
    end
     add_index :my_js_trees, :plantilla_id
  end
end
