class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :email_id
      t.string :url

      t.timestamps
    end
  end
end
