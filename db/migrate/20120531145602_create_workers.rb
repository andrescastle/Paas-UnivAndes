class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :first_name

      t.timestamps
    end
  end
end
