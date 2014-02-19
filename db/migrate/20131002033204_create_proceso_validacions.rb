class CreateProcesoValidacions < ActiveRecord::Migration
  def change
    create_table :proceso_validacions do |t|
      t.integer :proceso_id
      t.string :error_message
      t.string :tipo

      t.timestamps
    end
  end
end
