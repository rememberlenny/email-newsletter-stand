class Newsletter < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  validates_presence_of :name, :slug
  after_create :generate_uid
  after_create :refresh_sitemap
  before_save :check_slug
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
    emails = Newsletter.where(uid: uid[0])
    return emails[0]
  end

  def page_url
    Rails.application.routes.url_helpers.newsletter_path(self)
  end

  def featured_image_url
    Refile.attachment_url(self, :featured_image, :fill, 300, 300, format: "jpg", host: Refile.host)
  end

  def self.get_ograph_image id
    n = Newsletter.friendly.find id
    og = OpenGraph.new(n.url)
    if n.image_url.nil?
      n.image_url = og.images.first
      n.save
    end
  end

  def generate_uid
    uid = SecureRandom.hex(6)
    checked = Newsletter.check_is_unique_uid(uid)
    if checked == true
      self.uid = uid
      self.save
    else
      generate_uid
    end
  end

  def self.check_is_unique_uid uid
    uu = Newsletter.where(uid: uid)
    if uu.count == 0
      return true
    end
    return false
  end

  def refresh_sitemap
    SitemapGenerator::Interpreter.run(config_file:'config/sitemap.rb')
    SitemapGenerator::Sitemap.ping_search_engines
  end

  delayed :refresh_sitemap

  def check_slug
    if self.slug.empty?

    end
  end

end
