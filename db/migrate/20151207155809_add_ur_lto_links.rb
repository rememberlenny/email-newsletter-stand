class AddUrLtoLinks < ActiveRecord::Migration
  def change
  	add_column :links, :url_host, :string
  	add_column :links, :url_path, :text
  end
end
