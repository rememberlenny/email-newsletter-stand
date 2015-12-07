class AddOgraphUrl < ActiveRecord::Migration
  def change
  	add_column :links, :original_url, :string
  end
end
