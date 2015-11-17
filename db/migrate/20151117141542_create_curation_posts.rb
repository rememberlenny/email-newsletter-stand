class CreateCurationPosts < ActiveRecord::Migration
  def change
    create_table :curation_posts do |t|
      t.integer :curation_id
      t.integer :newsletter_id

      t.timestamps
    end
  end
end
