class RemoveTheType < ActiveRecord::Migration
  def change
  	remove_column :links, :type, :text
  	add_column :links, :linktype, :text
  end
end
