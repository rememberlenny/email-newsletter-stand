class AddOriginalLinks < ActiveRecord::Migration
  def change
  	add_column :links, :origin_url, :text
  end
end
