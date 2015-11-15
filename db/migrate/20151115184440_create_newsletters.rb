class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :name
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
