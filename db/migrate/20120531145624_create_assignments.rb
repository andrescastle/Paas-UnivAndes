class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :project
      t.references :worker
      t.date :assigned_at

      t.timestamps
    end
    add_index :assignments, :project_id
    add_index :assignments, :worker_id
    add_index :assignments,[:project_id, :worker_id], unique: true
  end
end
