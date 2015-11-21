class AddSlugToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :slug, :string, unique: true
  end
end
