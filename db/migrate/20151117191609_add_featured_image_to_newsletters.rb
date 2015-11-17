class AddFeaturedImageToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :featured_image_id, :string
  end
end
