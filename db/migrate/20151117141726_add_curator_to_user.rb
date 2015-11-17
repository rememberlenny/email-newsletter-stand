class AddCuratorToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_curator, :boolean
  end
end
