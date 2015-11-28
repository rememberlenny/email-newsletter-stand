class SetupSlugOnNewsletter < ActiveRecord::Migration
  def self.up
    remove_column :newsletters, :slug
    add_column :newsletters, :slug, :string
    add_index :newsletters, :slug, :unique => true
  end
end
