class Curation < ActiveRecord::Base
  has_many :curation_posts
  accepts_nested_attributes_for :curation_posts, reject_if: :all_blank, allow_destroy: true
end
