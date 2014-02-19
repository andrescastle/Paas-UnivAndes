class AddProcesoToEvento < ActiveRecord::Migration
  def change
    add_column :eventos, :proceso_id, :integer
  end
end
