class SetupSlugOnEmail < ActiveRecord::Migration
  def self.up
    add_column :emails, :slug, :string
    add_index :emails, :slug, :unique => true
  end
end
