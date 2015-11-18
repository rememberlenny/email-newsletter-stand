class Newsletter < ActiveRecord::Base
  attachment :featured_image
  acts_as_taggable
  include AlgoliaSearch

  algoliasearch do
    add_attribute :extra_tags
  end

  def extra_tags
    attribute :_tags do
      name_will_change!
      tags.map(&:name)
    end
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
