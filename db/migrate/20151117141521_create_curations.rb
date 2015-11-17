class CreateCurations < ActiveRecord::Migration
  def change
    create_table :curations do |t|
      t.string :name
      t.string :placement

      t.timestamps
    end
  end
end
