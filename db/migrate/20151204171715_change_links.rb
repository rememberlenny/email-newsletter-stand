class ChangeLinks < ActiveRecord::Migration
  def change
  	remove_column :links, :url
  	add_column :links, :url, :text
  end
end
