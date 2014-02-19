class CreateTareaPresedencia < ActiveRecord::Migration
  def change
    create_table :tarea_presedencia do |t|
      t.integer :predecesora_id
      t.integer :sucesora_id
      t.string :tipo_relacion

      t.timestamps
    end
  end
end
