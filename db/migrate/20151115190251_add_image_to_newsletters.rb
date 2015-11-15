class AddImageToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :image_url, :string
  end
end
