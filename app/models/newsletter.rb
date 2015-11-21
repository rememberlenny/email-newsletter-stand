class Newsletter < ActiveRecord::Base
  attachment :featured_image
  acts_as_taggable
  acts_as_votable
  include AlgoliaSearch

  algoliasearch per_environment: true do
    add_attribute :featured_image_url
    add_attribute :page_url
  end

  def self.find_by_email email
    uid = email.split('@emailnewsletterpost.com')
    emails = Newsletter.where(uid[0])
    return emails[0]
  end

  def page_url
    Rails.application.routes.url_helpers.newsletter_path(self)
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
