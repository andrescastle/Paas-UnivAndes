class CreateActividadRevisions < ActiveRecord::Migration
  def change
    create_table :actividad_revisions do |t|
      t.integer :id
      t.string :nombre
      t.integer :actividad_id
      t.integer :tipo_recurso_id

      t.timestamps
    end
  end
end
