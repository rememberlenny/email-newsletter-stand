class Newsletter < ActiveRecord::Base
  attachment :featured_image

  def self.get_ograph_image id
    n = Newsletter.find id
    og = OpenGraph.new(n.url)
    if n.image_url.nil?
      n.image_url = og.images.first
      n.save
    end
  end
end
