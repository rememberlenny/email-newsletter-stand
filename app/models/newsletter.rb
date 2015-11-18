class Newsletter < ActiveRecord::Base
  attachment :featured_image
  acts_as_taggable
  include AlgoliaSearch

  algoliasearch per_environment: true do
    add_attribute :featured_image_url
  end

  def featured_image_url
    Refile.attachment_url(self, :featured_image, :fill, 300, 300, format: "jpg", host: Refile.host)
  end

  def self.get_ograph_image id
    n = Newsletter.find id
    og = OpenGraph.new(n.url)
    if n.image_url.nil?
      n.image_url = og.images.first
      n.save
    end
  end
end
