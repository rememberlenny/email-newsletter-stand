class AddUidForNewsletter < ActiveRecord::Migration
  def change
    add_column :newsletters, :uid, :string
  end
end
