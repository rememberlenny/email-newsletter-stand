class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :url
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
