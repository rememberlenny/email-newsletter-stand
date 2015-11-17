class Newsletter < ActiveRecord::Base
  attachment :featured_image
  acts_as_taggable

  def self.get_ograph_image id
    n = Newsletter.find id
    og = OpenGraph.new(n.url)
    if n.image_url.nil?
      n.image_url = og.images.first
      n.save
    end
  end
end
