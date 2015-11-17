class Curation < ActiveRecord::Base
  has_many :curated_posts
  accepts_nested_attributes_for :curated_posts, allow_destroy: true
end
