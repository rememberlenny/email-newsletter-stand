class AddOgraphUrl < ActiveRecord::Migration
  def change
  	remove_column :links, :original_url, :string
  	add_column :links, :original_url, :text
  end
end
