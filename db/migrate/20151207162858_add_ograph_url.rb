class AddOgraphUrl < ActiveRecord::Migration
  def change
  	add_column :links, :original_url, :text
  end
end
