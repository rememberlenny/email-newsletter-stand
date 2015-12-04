class AddOriginEmail < ActiveRecord::Migration
  def change
  	add_column :emails, :origin_body, :text
  	add_column :emails, :origin_raw_html, :text
  end
end
