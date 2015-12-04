class AddOgraphToLinks < ActiveRecord::Migration
  def change
		add_column :links, :title, :text
		add_column :links, :type, :text
		add_column :links, :description, :text
  end
end
