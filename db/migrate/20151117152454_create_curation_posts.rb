class CreateCurationPosts < ActiveRecord::Migration
  def change
    create_table :curation_posts do |t|
      t.integer :curation_id
      t.integer :newsletter_id
      t.belongs_to :curations, index: true

      t.timestamps
    end
  end
end
