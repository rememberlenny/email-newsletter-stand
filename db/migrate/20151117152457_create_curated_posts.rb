class CreateCuratedPosts < ActiveRecord::Migration
  def change
    create_table :curated_posts do |t|
      t.integer :curation_id
      t.integer :newsletter_id
      t.belongs_to :curation, index: true

      t.timestamps
    end
  end
end
