class Newsletter < ActiveRecord::Base

  def self.get_ograph_image id
    n = Newsletter.find id
    og = OpenGraph.new(n.url)
  end
